# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'hashy_db'

Gem::Specification.new do |s|
  s.name        = "hashy_db"
  s.version     = HashyDb.version
  s.authors     = ["Matt Simpson", "Jason Mayer", "Asynchrony"]
  s.email       = ["matt@railsgrammer.com", "jason.mayer@gmail.com"]
  s.homepage    = "https://github.com/asynchrony/#{s.name}"
  s.summary     = %q{Library to interact with in-memory hash database collections}
  s.description = %q{Library to interact with in-memory hash database collections. Offers very little technical dependencies.  In order to develop or run the tests for your application you just need ruby installed, run bundle install and you're good to go.  No need to install and start your database, migrate, etc.}

  s.rubyforge_project = s.name

  s.files         = %w(lib/hashy_db.rb lib/hashy_db/data_store.rb lib/hashy_db/version.rb)
  s.test_files    = %w(spec/lib/data_store_spec.rb)
  s.require_paths = ["lib"]

  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
  s.add_development_dependency('guard-rspec')
end
