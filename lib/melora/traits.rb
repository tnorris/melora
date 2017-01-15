# frozen_string_literal: true
require 'yaml'

# @todo extend enumeratable
# A map of [String] skill => [String] Dice needed to roll it
class Melora::Traits
  attr_reader :traits

  def initialize(yaml_path)
    begin
      @stats_hash = YAML.load(File.read(yaml_path))
    rescue StandardError => e
      $stderr.puts e
      raise e
    end

    raise TypeError, "Unable to parse #{yaml_path}. Is it valid yaml?" unless @stats_hash.class == Hash

    @traits = {}
    denormalize_stats_hash
  end

  private

  def method_missing(method, *thing)
    if '[]' == method.id2name
      @traits.fetch(thing.join(''))
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    method_name.to_s == '[]' || super
  end

  def denormalize_stats_hash # rubocop:disable MethodLength
    @stats_hash.each do |category, category_hash|
      # skip the name, occupation, etc
      next if 'meta' == category

      faces = @stats_hash[category]['base']['faces']
      dice = @stats_hash[category]['base']['dice']
      @traits[category] = "#{dice}d#{faces}"

      category_hash.each do |trait, multiplier|
        # skip the category's base dice
        next if 'base' == trait
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
