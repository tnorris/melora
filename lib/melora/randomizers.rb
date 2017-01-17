# frozen_string_literal: true
# The autoloader for Randomizer classes
class Melora::Randomizers
  # @todo 'Marshal needs her "special roll of totally not cheating"'

  # @todo make fair seedable
  autoload :Fair, './lib/melora/randomizers/fair'
end
