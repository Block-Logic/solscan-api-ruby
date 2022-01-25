# frozen_string_literal: true

require_relative 'lib/solscan_api_ruby/version'

Gem::Specification.new do |spec|
  spec.name                  = 'solscan_api_ruby'
  spec.version               = SolscanApiRuby::VERSION
  spec.authors               = ['Block Logic Team']
  spec.email                 = ['email@example.com']
  spec.summary               = 'Ruby wrapper for solscan public API (https://public-api.solscan.io/docs/#/).'
  spec.description           = 'This gem allows to use solscan public API witihin ruby ecosystem.'
  spec.homepage              = 'https://github.com/Block-Logic/solscan-api-ruby'
  spec.license               = 'MIT'
  spec.platform              = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.6.5'
  spec.files = Dir[
    'README.md', 'LICENSE', 'CHANGELOG.md',
    'lib/**/*.rb',
    'lib/**/*.rake',
    'solscan_api_ruby.gemspec',
    '.github/*.md',
    'Gemfile',
    'Rakefile'
  ]
  spec.extra_rdoc_files = ['README.md']

  spec.add_development_dependency 'pry', '~> 0.14'
  spec.add_development_dependency 'rubocop', '~> 1.25'
  spec.add_development_dependency 'rubocop-performance', '~> 1.13'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.3'

  spec.add_development_dependency 'dotenv', '~> 2.7'
  spec.add_development_dependency 'rails', '~> 6.1'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'rspec-rails', '~> 5.0'
  spec.add_development_dependency 'simplecov', '~> 0.21'
  spec.add_development_dependency 'vcr', '~> 6.0'
  spec.add_development_dependency 'webmock', '~> 3.14'
end
