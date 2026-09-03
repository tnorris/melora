# frozen_string_literal: true

require 'yaml'

# @todo extend enumeratable
class Melora::Traits
  # @attribute [Hash<String>] => [String] Hashmap of trait_name -> dice_pool_notation
  attr_reader :traits

  def initialize(yaml_path)
    @stats_hash = YAML.safe_load(File.read(yaml_path))
    raise TypeError, "Unable to parse #{yaml_path}. Is it valid yaml?" unless @stats_hash.instance_of?(Hash)

    @traits = {}
    denormalize_stats_hash
  end

  # Look up the dice notation for a trait
  # @param [String] thing a trait name
  # @return [String] the dice notation for the trait
  def [](thing)
    @traits.fetch(thing)
  end

  private

  def denormalize_stats_hash # rubocop:disable Metrics/MethodLength
    @stats_hash.each do |category, category_hash|
      # skip the name, occupation, etc
      next if category == 'meta'

      faces = @stats_hash[category]['base']['faces']
      dice = @stats_hash[category]['base']['dice']
      @traits[category] = "#{dice}d#{faces}"

      category_hash.each do |trait, multiplier|
        # skip the category's base dice
        next if trait == 'base'

        @traits[trait] = if multiplier
                           "#{multiplier}d#{faces}"
                         else
                           "1d#{faces}-4"
                         end
      end
    end

    @traits
  end
end
