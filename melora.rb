# A character in deadlands
# Can roll dice pools, load a character sheet (with traits) from a YAML
#
# @author Tom Norris <tom.norris.iv@gmail.com>
class Melora
  autoload :DicePool, './lib/melora/dicepool'
  autoload :Traits, './lib/melora/traits'
end

# How to use:
# => m = Melora.new
# => m.roll_pool(exploding: true, faces: 6, number_of_dice: 3)
