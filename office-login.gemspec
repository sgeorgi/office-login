# -*- encoding: utf-8 -*-
require File.expand_path('../lib/office-login/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Sebastian Georgi"]
  gem.email         = ["sgeorgi@sgeorgi.de"]
  gem.description   = %q{CLI tool to log-in to the office's network via headless browser}
  gem.summary       = %q{...}
  gem.homepage      = "https://github.com/sgeorgi/office-login"

  gem.add_dependency 'watir-webdriver'
  gem.add_dependency 'headless'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "office-login"
  gem.require_paths = ["lib"]
  gem.version       = Office::Login::VERSION
end
