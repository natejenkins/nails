# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nails/version'

Gem::Specification.new do |gem|
  gem.name          = "nails"
  gem.version       = Nails::VERSION
  gem.authors       = ["Nathan Jenkins"]
  gem.email         = ["nate.jenkins@gmail.com"]
  gem.description   = "Insultingly simple rails clone"
  gem.summary       = "Insultingly simple rails clone"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency 'rack', '~> 1.4'
  gem.add_dependency 'sqlite3', '~> 1.3.9'
end
