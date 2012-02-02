# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'hashydb/version'

Gem::Specification.new do |s|
  s.name        = "hashydb"
  s.version     = HashyDB::VERSION
  s.authors     = ["Matt Simpson", "Jason Mayer"]
  s.email       = ["matt.simpson3@gmail.com", "jason.mayer@gmail.com"]
  s.homepage    = "https://github.com/coffeencoke/HashyDB"
  s.summary     = %q{Provides an inteface to store and retrieve data in a Hash.}
  s.description = %q{Provides an inteface to store and retrieve data in a Hash.}

  s.rubyforge_project = "hashydb"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('activesupport', '~> 3.1.3')
  
  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
end
