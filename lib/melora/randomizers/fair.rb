# frozen_string_literal: true
# A simple dice roller
class Melora::Randomizers::Fair
  def initialize(params = {})
    @faces = params.fetch(:faces)
  end

  def rand
    Random.rand(@faces)
  end
end
