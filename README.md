# What is this?

Provides an inteface to store and retrieve data in a Hash.  

# Why would you want this?

- To defer choosing your database until you know most about your application.
- Provides assitance in designing a database agnostic architecture.

The hash can be loaded in memory and be used as your data store.  

Example in a rails app:

initializers/datastore.rb

`ruby
::DB_HASH = {}
`

# Todos

- Make this into a gem
- Rename *.get_one into *.find
- Add a better readme

# Contribute

- fork into a topic branch, write specs, make a pull request.

# Contributors

## Matt Simpson

* https://twitter.com/railsgrammer
* https://github.com/coffeencoke

## Jason Mayer

* https://twitter.com/farkerhaiku
* https://github.com/farkerhaiku
