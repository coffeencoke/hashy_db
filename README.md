# What is this?

Light weight ORM to persist data to a hash. 

# Why would you want this?

- To defer choosing your database until you know most about your application.
- Provides assitance in designing a database agnostic architecture.

The hash can be loaded in memory and be used as your data store.  

Example in a rails app:

initializers/datastore.rb

`
::DB_HASH = {}
`

View the examples folder for an example implementation.

# Contribute

- fork into a topic branch, write specs, make a pull request.

# Owners

Matt Simpson - [@railsgrammer](https://twitter.com/railsgrammer)
<br />
Jason Mayer - [@farkerhaiku](https://twitter.com/farkerhaiku)

# Contributors

David Czarnecki - [@czarneckid](https://twitter.com/czarneckid)
