# frozen_string_literal: true

require_relative 'lib/fuga/gig/version'

Gem::Specification.new do |spec|
  spec.name          = 'fuga-gig'
  spec.version       = Fuga::Gig::VERSION
  spec.authors       = ['Viktar Makayed']
  spec.email         = ['vmakoed@gmail.com']

  spec.summary       = 'Download avatars of Github repository owners'
  spec.description   = <<-DESCRIPTION
    A command line tool using the public Github API to download and save avatar
    images from repository owners matching the provided search criteria.
  DESCRIPTION

  spec.homepage = 'https://github.com/vmakoed/fuga-gig'
  spec.required_ruby_version = '>= 3.0.1'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rspec', '~> 3.10.0'
  spec.add_development_dependency 'vcr', '~> 6.0'
  spec.add_development_dependency 'webmock', '~> 3.13'
end
