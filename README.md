# What is hashy db?

Light weight ORM to persist data to a hash. 

Provides an interface for storing and retreiving information to a Hash.

The motivation behind this is so you can clone the repository down, have ruby installed, run bundle install and be able to run your tests and develop without being dependent on any other setup.

[@github](https://github.com/asynchrony/HashyDB)
[@rubygems](https://rubygems.org/gems/hashy_db)

# How to use

view the [example mince rails app](https://github.com/coffeencoke/mince_rails_example) to see how to use this.

Basic usage is to create a constant called DB_HASH and set it to an empty hash in an initializer file, or whenever your application gets loaded (if you're not running rails).

<pre>
# initializers/datastore.rb
::DB_HASH = {}
</pre>

From there you can use Hashy Db to add and retrieve data.

<pre>
# Add a book to the books collection
HashyDb::DataStore.add 'books', title: 'The World In Photographs', publisher: 'National Geographic'

# Retrieve all records from the books collection
HashyDb::DataStore.find_all 'books'

# Replace a specific book
HashyDb::DataStore.replace 'books', title: 'A World In Photographs', publisher: 'National Geographic'
</pre>

View the [data_store.rb](https://github.com/asynchrony/hashy_db/blob/master/lib/hashy_db/data_store.rb) file for all methods available.

Use with [mince data model](https://github.com/asynchrony/mince_data_model) to make it easy to change from one data storage to another, like [Mince](https://github.com/asynchrony/mince), a MongoDB implementation.


# Why would you want this?

- To defer choosing your database until you know most about your application.
- Provides assitance in designing a database agnostic architecture.
- Offers very little technical dependencies.  In order to develop or run the tests for your application you just need ruby installed, run bundle install and you're good to go.  No need to install and start your database, migrate, etc.

The hash can be loaded in memory and be used as your data store.  

# Contribute

- fork into a topic branch, write specs, make a pull request.

# Owners

Matt Simpson - [@railsgrammer](https://twitter.com/railsgrammer)

Jason Mayer - [@farkerhaiku](https://twitter.com/farkerhaiku)

# Contributors

David Czarnecki - [@czarneckid](https://twitter.com/czarneckid)
Amos King - [@adkron](https://twitter.com/adkron)
