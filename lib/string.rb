# frozen_string_literal: true

# Helpers for Strings
class Melora::String
  class << self
    # Turns a string like "3d6+10", "d6", or "d6-1" into a hash that can be passed into DicePool.new
    # As the joke goes: Now I have \d+ problems!
    def parse_d_notation_string(string)
      validate_d_notation(string)
      number_of_dice, faces, modifier = string.match(d_notation_regex).captures.map(&:to_i)
      number_of_dice = 1 if number_of_dice.zero?

      # something went wrong while parsing
      raise TypeError if faces.zero?

      { number_of_dice: number_of_dice,
        faces: faces,
        modifier: modifier }
    end

    def validate_d_notation(string)
      raise TypeError unless string =~ d_notation_regex
    end

    def d_notation_regex
      /(?<number_of_dice>\d+)?(?:d(?<faces>\d+))?(?<modifier>[+-]\d+)?/
    end

    def old_timey_cowboyize(string)
      string.split(' ').map { |i| i.gsub(/ing$/, "in'") }.join ' '
    end
  end
end
