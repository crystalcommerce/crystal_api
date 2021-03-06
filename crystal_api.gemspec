# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crystal_api/version'

Gem::Specification.new do |gem|
  gem.name          = "crystal_api"
  gem.version       = CrystalApi::VERSION
  gem.authors       = ["Donald Plummer"]
  gem.email         = ["username@crystalcommerce.com"]
  gem.description   = %q{A library for using the CrystalCommerce API.}
  gem.summary       = %q{A library for using the CrystalCommerce API.}
  gem.homepage      = "http://apidocs.crystalcommerce.com"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "money"
  gem.add_dependency "values"
  gem.add_dependency "activesupport"
  gem.add_dependency "httparty"
  gem.add_dependency "multi_json"

  gem.add_development_dependency 'rspec', '~> 2.11.0'
  gem.add_development_dependency 'guard', '~> 1.2.3'
  gem.add_development_dependency 'guard-rspec', '~> 1.2.1'
  gem.add_development_dependency 'vcr', '~> 2.9'
  gem.add_development_dependency 'webmock', '~> 1.8.0'
  gem.add_development_dependency 'libnotify'
  gem.add_development_dependency 'rb-inotify', '~> 0.8.8'
  gem.add_development_dependency 'pry'
end
