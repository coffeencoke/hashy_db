# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'hashy_db/version'

Gem::Specification.new do |s|
  s.name        = "hashy_db"
  s.version     = HashyDb::VERSION
  s.authors     = ["Matt Simpson", "Jason Mayer"]
  s.email       = ["matt@railsgrammer.com", "jason.mayer@gmail.com"]
  s.homepage    = "https://github.com/asynchrony/HashyDb"
  s.summary     = %q{Provides an interface to store and retrieve data in a Hash.}
  s.description = %q{Provides an interface to store and retrieve data in a Hash.}

  s.rubyforge_project = "hashy_db"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('activesupport', '~> 3.1')
  
  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
end
