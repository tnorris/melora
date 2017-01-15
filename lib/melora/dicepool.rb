# frozen_string_literal: true
#
# A bucket of dice for you to throw at the table
# @attr_reader [Array<Integer>] A record of dice we've thrown on the table
class Melora::DicePool
  attr_accessor :faces, :number_of_dice, :modifier, :exploding, :horrible_failure, :sort
  attr_reader :results
  attr_reader :table

  # @param [Hash] params The configuration to roll a pool of dice
  # @option params [Integer] :faces The number of sides your dice have
  # @option params [Integer] :number_of_dice Number of dice to roll
  # @option params [Integer] :exploding Re-roll-and-add if the random number is the max number on the die
  # @option params [TrueClass|FalseClass] :horrible_failure lets you know if more than half of your pool was a failure
  # @option params [:asc,:desc,nil] :sort dice sort order, nil means don't sort
  # @option params [Integer] :modifier a bonus (or penalty, if negative) to apply to each die in the roll
  # @option params [TrueClass|FalseClass] :clamp_positive Ensure all rolls are > 0
  def initialize(params = {})
    @faces = params.fetch :faces, 6
    @number_of_dice = params.fetch :number_of_dice, 1
    @modifier = params.fetch :modifier, 0
    @exploding = params.fetch :exploding, true
    @horrible_failure = params.fetch :horrible_failure, false
    @sort = params.fetch :sort, :desc
    @clamp_positive = params.fetch :clamp_positive, true

    @results = []

    validate
  end

  # Throw a bucket of dice onto the table
  # @return [Array<Fixnum>]
  def roll_pool
    @table = (1..@number_of_dice).to_a.map do
      clamp_helper(roll_die + @modifier)
    end

    @results << sort_table

    $stderr.puts '/!\ You failed horribly' if @horrible_failure && rolled_horribly?

    @results.last
  end
  alias roll roll_pool

  # ======================================================================

  private

  # ======================================================================

  # Clamps a number if we should
  def clamp_helper(number)
    @clamp_positive && number < 1 ? 1 : number
  end

  # Sorts the table array
  def sort_table
    case @sort
    when :asc
      @table.sort
    when :desc
      @table.sort.reverse
    else
      @table
    end
  end

  # Did we roll horribly? (more than half the pool was a '1')
  def rolled_horribly?
    @table.count(1) >= (@table.size / 2.0).ceil
  end

  # Helper to validate that an obj called obj_name is the expected_type
  # @param [String] obj_name The variable name of the object
  # @param [Object] obj The thing to validate
  # @param [Class|Array<Class>] expected_type The allowed class(es) obj can be
  def validate_type(obj_name, obj, expected_type)
    if expected_type.is_a? Array
      valid_types = expected_type.join '|'
      valid = expected_type.include? obj.class
    else
      valid_types = expected_type
      valid = obj.class == expected_type
    end

    raise(TypeError, "#{obj_name} must be a #{valid_types}, it was #{obj} (#{obj.class})") unless valid
  end

  # Makes sure the initializer was called correctly
  def validate
    { faces: @faces,
      number_of_dice: @number_of_dice,
      modifier: @modifier }.each do |k, v|
      validate_type k, v, Fixnum # rubocop:disable UnifiedInteger
    end

    { horrible_failure: @horrible_failure,
      exploding: @exploding }.each do |k, v|
      validate_type k, v, [TrueClass, FalseClass]
    end

    validate_type :sort, @sort, [Symbol, NilClass]
  end

  # Rolls a single die, exploding if appropriate
  def roll_die
    # rand is from 0..faces exclusive.
    roll = rand(@faces) + 1

    if @exploding && roll == @faces
      $stderr.puts 'Pop!'
      roll += roll_die
    end

    roll
  end
end