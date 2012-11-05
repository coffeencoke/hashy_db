# HashyDb

[![Travis CI](https://travis-ci.org/coffeencoke/hashy_db.png)](https://travis-ci.org/#!/coffeencoke/hashy_db)

HashyDb is a ruby in-memory hash database to provide a quick way to develop without any external database dependency in Ruby applications.

HashyDb is a database interface that abides to the [Mince](https://github.com/coffeencoke/mince/) interface API requirements and is officially supported by [Mince](https://github.com/coffeencoke/mince/).

# How to use it

View the [Mince Wiki](https://github.com/coffeencoke/mince/wiki) on details on how to use this gem.

Basically -

```
gem install mince hashy_db
```

```ruby
require 'mince'
require 'hashy_db'
interface = Mince::HashyDb::Interface # => Mince::HashyDb::Interface 
interface.add 'tron_light_cycles', luminating_color: 'red', grid_locked: true, rezzed: false
interface.add 'tron_light_cycles', luminating_color: 'blue', grid_locked: true, rezzed: true
interface.find_all('tron_light_cycles') 
	# => [{:luminating_color=>"red", :grid_locked=>true, :rezzed=>false}, {:luminating_color=>"blue", :grid_locked=>true, :rezzed=>true}] 
interface.get_for_key_with_value('tron_light_cycles', :luminating_color, 'blue')
	# => {:luminating_color=>"blue", :grid_locked=>true, :rezzed=>true} 
```

# Links

* [API Docs](http://rdoc.info/github/coffeencoke/hashy_db/master/frames)
* [Rubygems](https://rubygems.org/gems/hashy_db)
* [Github](https://github.com/coffeencoke/hashy_db)
* [Wiki](https://github.com/coffeencoke/hashy_db/wiki)
* [Mailing List](https://groups.google.com/forum/?fromgroups#!forum/mince_dev)
* [Mince](https://github.com/coffeencoke/mince)

# Why would you want this?

- To defer choosing your database until you know most about your application.
- Provides assistance in designing and developing a database agnostic application.
- Offers very little technical dependencies.  In order to develop or run the tests for your application you just need ruby installed, run bundle install and you're good to go.  No need to install and start your database, migrate, etc.

# Contribute

This gem is officially supported by [Mince](https://github.com/coffeencoke/mince/), please go there to learn how to contribute.