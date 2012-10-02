module Mince
  module HashyDb # :nodoc:
    require 'singleton'

    # = HashyDb Data Store
    #
    # HashyDb Data Store stores and retrieves data from a ruby in-memory hash.
    #
    # Using this library offers more extensibility and growth for your application.  If at any point in time
    # you want to support a different database for all, or even one, of your classes, you only need to implement
    # the few methods defined in this class.
    #
    # HashyDb Data Store is a singleton object that provides class level interface to the singleton instance.
    #
    #   Mince::HashyDb::DataStore.instance # => Mince::HashyDb::DataStore object
    #   Mince::HashyDb::DataStore.data # => returns all data stored in the HashyDb database
    #   Mince::HashyDb::DataStore.collection(:some_collection) # => returns all data stored in a specific collection in the HashyDb database
    #
    # @author Matt Simpson
    class DataStore
      include Singleton

      # Sets the entire data store, for all collections
      #
      # @param [Hash] hash the hash to replace the entire data store with
      def self.set_data(hash)
        instance.data = hash
      end

      # Class level access to the in-memory data store
      #
      # @return [Hash] all collections along with the contents of each collection
      def self.data
        instance.data
      end

      # The collection in the data store
      #
      # @param [Symbol] collection_name the name of the collection
      # @return [Array] all records in the collection, defaults to an empty array
      def self.collection(collection_name)
        data[collection_name] ||= []
      end

      # The attribute containing the data
      #
      # @return [Hash] all collections along with the contents of each collection, defaults to an empty hash
      attr_accessor :data

      def initialize
        @data = {}
      end
    end
  end
end
