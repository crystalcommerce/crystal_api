# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crystal_api/version'

Gem::Specification.new do |gem|
  gem.name          = "crystal_api"
  gem.version       = CrystalApi::VERSION
  gem.authors       = ["Donald Plummer"]
  gem.email         = ["donald@cideasphere.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency("money", "~> 5")
  gem.add_dependency("values", "~> 1.2.1")

  gem.add_development_dependency('rspec', '~> 2.11.0')
  gem.add_development_dependency('guard', '~> 1.2.3')
  gem.add_development_dependency('guard-rspec', '~> 1.2.1')
  gem.add_development_dependency('vcr', '~> 2.2.4')
end
