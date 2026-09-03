# frozen_string_literal: true

require_relative 'lib/melora'

Gem::Specification.new do |spec|
  spec.name = 'melora'
  spec.version = Melora::VERSION
  spec.authors = ['Jen Norris']
  spec.email = ['jen@rellis.house']

  spec.summary = 'Deadlands dice rolling tools'
  spec.description = 'Dice rolling tools for the Deadlands roleplaying game.'
  spec.homepage = 'https://github.com/tnorris/melora'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.2'

  spec.metadata['source_code_uri'] = 'https://github.com/tnorris/melora'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['lib/**/*.rb']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'pry', '~> 0.14'
  spec.add_development_dependency 'rspec', '~> 3.13'
  spec.add_development_dependency 'rubocop', '~> 1.90'
end
