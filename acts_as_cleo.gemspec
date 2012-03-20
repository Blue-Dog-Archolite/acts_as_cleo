# -*- encoding: utf-8 -*-
require File.expand_path('../lib/acts_as_cleo/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Robert R. Meyer"]
  gem.email         = ["Blue.Dog.Archolite@gmail.com"]
  gem.description   = %q{A Cleo Inegration Gem}
  gem.summary       = %q{A Rails interface for the Cleo REST API}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "acts_as_cleo"
  gem.require_paths = ["lib"]
  gem.version       = ActsAsCleo::VERSION

  gem.add_development_dependency 'bundler'
  gem.add_dependency 'rails'
  gem.add_dependency 'happymapper'
end
