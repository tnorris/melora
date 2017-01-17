# frozen_string_literal: true
# A character in deadlands
# Can roll dice pools, load a character sheet (with traits) from a YAML
#
# @author Tom Norris <tom.norris.iv@gmail.com>
class Melora
  # buckets of dice to throw at the table, and the logic to roll them
  autoload :DicePool, './lib/melora/dicepool'

  # the autoloader for Randomizer
  autoload :Randomizers, './lib/melora/randomizers'

  # helpers for dice notation => dicepool config, old timey cowboy talk
  autoload :String, './lib/melora/string'

  # stats, part of your character sheet
  autoload :Traits, './lib/melora/traits'
end

# Monkeypatch String because metaprogramming is cool
class String
  def to_dicepool
    Melora::String.parse_d_notation_string self
  end

  def to_old_timey_cowboy
    Melora::String.old_timey_cowboyize self
  end
end
