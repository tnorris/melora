# frozen_string_literal: true
# A character in deadlands
# Can roll dice pools, load a character sheet (with traits) from a YAML
#
# @author Tom Norris <tom.norris.iv@gmail.com>
class Melora
  # buckets of dice to throw at the table, and the logic to roll them
  autoload :DicePool, './lib/melora/dicepool'

  # stats, part of your character sheet
  autoload :Traits, './lib/melora/traits'

  # Turns a string like "3d6+10", "d6", or "d6-1" into a hash that can be passed into DicePool.new
  # As the joke goes: Now I have \d+ problems!
  def self.parse_d_notation_string(s)
    parser_regex = /(?<number_of_dice>\d+){0,1}(d(?<faces>\d+)){0,1}(?<modifier>[+-]\d+){0,1}/
    number_of_dice, faces, modifier = s.match(parser_regex).captures.map(&:to_i)
    number_of_dice = 1 if number_of_dice.zero?
    { number_of_dice: number_of_dice,
      faces: faces,
      modifier: modifier }
  end

  def self.old_timey_cowboyize(s)
    s.split(' ').map { |i| i.gsub(/ing$/, 'in') }.join ' '
  end
end

# Monkeypatch String because metaprogramming is cool
class String
  def to_dicepool
    Melora.parse_d_notation_string self
  end

  def to_old_timey_cowboy
    Melora.old_timey_cowboyize self
  end
end
