# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'hashy_db'

Gem::Specification.new do |s|
  s.name        = "hashy_db"
  s.version     = Mince::HashyDb.version
  s.authors     = ["Matt Simpson", "Jason Mayer", "Asynchrony"]
  s.email       = ["matt@railsgrammer.com", "jason.mayer@gmail.com"]
  s.homepage    = "https://github.com/coffeencoke/#{s.name}"
  s.summary     = %q{Ruby library to interact with in-memory hash database collections}
  s.description = <<-EOF
    Ruby library to interact with in-memory hash database collections. Offers very little technical dependencies.  
    In order to develop or run the tests for your application you just need ruby installed, run bundle install and 
    you're good to go.  No need to install and start your database, migrate, etc.
  EOF

  s.rubyforge_project = s.name
  s.has_rdoc = true
  s.files         = %w(
    lib/hashy_db.rb 
    lib/hashy_db/data_store.rb 
    lib/hashy_db/version.rb 
    lib/hashy_db/config.rb 
    lib/hashy_db/interface.rb
  )
  s.test_files    = %w(
    spec/integration/mince_interface_spec.rb
    spec/units/hashy_db/config_spec.rb
    spec/units/hashy_db/data_store_spec.rb
    spec/units/hashy_db/interface_spec.rb
  )
  s.require_paths = ["lib"]

  s.required_ruby_version = '~> 1.9.0'

  s.add_development_dependency('rake', '~> 0.9')
  s.add_development_dependency('rspec', '~> 2.0')
  s.add_development_dependency('guard-rspec', '~> 0.6')
  s.add_development_dependency "yard", "~> 0.7"
  s.add_development_dependency "redcarpet", "~> 2.1"
  s.add_development_dependency "debugger", "~> 1.2"
  s.add_development_dependency "mince", "2.0.0.pre.2"
  s.add_development_dependency "rb-fsevent", "~> 0.9.0"
end
