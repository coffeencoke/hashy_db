module Mince
  module HashyDb # :nodoc:
    require 'digest'
    require_relative 'data_store'
    require_relative 'config'

    # = HashyDb Data Store
    #
    # HashyDb Data Store stores and retrieves data from a ruby in-memory hash.
    #
    # Using this library offers more extensibility and growth for your application.  If at any point in time
    # you want to support a different database for all, or even one, of your classes, you only need to implement
    # the few methods defined in this class.
    #
    #   HashyDb::DataStore.add 'fruits', id: '1', name: 'Shnawzberry', color: 'redish', quantity: '20'
    #   HashyDb::DataStore.get_for_key_with_value 'fruits', :color, 'redish'
    #
    # @author Matt Simpson
    module Interface

      # Generates a unique ID for a database record
      #
      # @note This is necessary because different databases use different types of primary key values. Thus, each mince
      #       implementation must define how to generate a unique id.
      #
      # @param [#to_s] salt any object that responds to #to_s
      # @return [String] A unique id based on the salt and the current time
      def self.generate_unique_id(salt)
        PrimaryKey.generate(salt)
      end

      def self.primary_key
        PrimaryKey.name
      end

      # Deletes a field from all records in the given collection
      #
      # @param [Symbol] collection_name the name of the collection
      # @param [symbol] field the name of the field to delete
      def self.delete_field(collection_name, field)
        find_all(collection_name).each do |row|
          row.delete(field)
        end
      end

      # Inserts one record into a collection.
      #
      # @param [Symbol] collection_name the name of the collection
      # @param [Hash] hash a hash of data to be added to the collection
      def self.add(collection_name, hash)
        find_all(collection_name) << hash
      end

      # Replaces a record in the collection based on the primary key's value.  The hash must contain a key, defined
      # by the +primary_key_identifier+ method, with a value.  If a record in the data store is found with that key and
      # value, the entire record will be replaced with the given hash.
      #
      # @param [Symbol] collection_name the name of the collection
      # @param [Hash] hash a hash to replace the record in the collection with
      def self.replace(collection_name, hash)
        collection = find_all(collection_name)
        index = collection.index{ |object| object[primary_key] == hash[primary_key] }
        collection[index] =  hash
      end

      # Deletes a record that matches the given criteria from the data store.
      def self.delete_by_params(collection_name, params)
        find_all(collection_name).reject! do |record|
          params.all?{|k,v| record[k] == v }
        end
      end

      # Updates the field with a value for the record for the given id.
      #
      # @param [Symbol] collection_name the name of the collection
      # @param [String] primary_key_value the id of the record
      # @param [Symbol] field_name the name of the field to update
      # @param [String] field_value the value to update the field to
      # @return [void] no specific return value
      def self.update_field_with_value(collection_name, primary_key_value, field_name, new_value)
        find(collection_name, primary_key_value)[field_name] = new_value
      end

      # Increments or decrements the field by the given amount for the record for the given id.
      #
      # @param [Symbol] collection_name the name of the collection
      # @param [String] primary_key_value the id of the record
      # @param [Symbol] field_name the name of the field to update
      # @param [String] amount the amount to increment or decrement the field by
      # @return [void] no specific return value
      def self.increment_field_by_amount(collection_name, primary_key_value, field_name, amount)
        find(collection_name, primary_key_value)[field_name] += amount
      end

      # Gets all records that have the value for a given key.
      #
      # @param [Symbol] collection_name the name of the collection
      # @param [String] key the key, or field, to get a record for
      # @param [*] value the value to get a record for
      # @return [Array] an array of records that match the key and value
      def self.get_all_for_key_with_value(collection_name, key, value)
        find_all(collection_name).select { |a| a[key] == value }
      end

      # Gets the first record that has the value for a given key.
      #
      # @param [Symbol] collection_name the name of the collection
      # @param [String] key the key to find a record by
      # @param [String] value the value to find a record by
      # @return [Hash] a hash for the record found by the key and value in the collection
      def self.get_for_key_with_value(collection_name, key, value)
        self.get_all_for_key_with_value(collection_name, key, value)[0]
      end

      # Gets all records that have all of the keys and values in the given hash.
      #
      # @param [Symbol] collection_name the name of the collection
      # @param [Hash] hash a hash to get a record for
      # @return [Array] an array of all records matching the given hash for the collection
      def self.get_by_params(collection_name, hash)
        self.find_all(collection_name).select do |record|
          hash.all?{|k,v| record[k] == v }
        end
      end

      # Gets all records for a collection
      #
      # @param [Symbol] collection_name the name of the collection
      # @return [Array] all records for the given collection name
      def self.find_all(collection_name)
        DataStore.collection(collection_name)
      end

      # Gets a record matching a key and value
      #
      # @param [Symbol] collection_name the name of the collection
      # @param [*] value a value the find a record by
      # @return [Hash] a record that matches the given key and value
      def self.find(collection_name, value)
        find_all(collection_name).find { |x| x[primary_key] == value }
      end

      # Pushes a value to a record's key that is an array
      #
      # @param [Symbol] collection_name the name of the collection
      # @param [*] identifying_value the value used to find the record
      # @param [String] array_key the field to push an array to
      # @param [*] value_to_push the value to push to the array
      def self.push_to_array(collection_name, identifying_value, array_key, value_to_push)
        record = find(collection_name, identifying_value)
        if (record[array_key])
          record[array_key] << value_to_push
        else
          record[array_key] = [value_to_push]
        end
        record[array_key].uniq!
      end

      # Removes a value from a record's key that is an array
      #
      # @param [Symbol] collection_name the name of the collection
      # @param [*] identifying_value the value used to find the record
      # @param [String] array_key the field to push an array from
      # @param [*] value_to_remove the value to remove from the array
      def self.remove_from_array(collection_name, identifying_value, array_key, value_to_pop)
        record = find(collection_name, identifying_value)
        record[array_key].reject! { |x| x == value_to_pop }
      end

      # Returns all records where the given key contains any of the values provided
      #
      # @param [Symbol] collection_name the name of the collection
      # @param [String] key the key to find the record by
      # @param [Array] values an array of values that the record could contain
      # @return [Array] all records that contain any of the values given
      def self.containing_any(collection_name, key, values)
        find_all(collection_name).select do |x|
          if x[key].is_a?(Array)
            (x[key] & values).any?
          else
            values.include?(x[key])
          end
        end
      end

      # Returns all records where the given key contains the given value
      #
      # @param [Symbol] collection_name the name of the collection
      # @param [String] key the key to find records by
      # @param [*] value the value to find a record by
      # @return [Array] all records where the key contains the given value
      def self.array_contains(collection_name, key, value)
        find_all(collection_name).select do |x|
          x[key] && x[key].include?(value)
        end
      end

      # Replaces the entire collection with the given data
      #
      # @param [Symbol] collection_name the name of the collection
      # @param [Array] data an array of data hashes to replace and insert into the collection
      def self.insert(collection_name, data_to_insert)
        data[collection_name] = data_to_insert
      end

      # Deletes an entire collection
      #
      # @param [Symbol] collection_name the collection to delete from the database
      # @return [Array] the records in the collection being deleted
      def self.delete_collection(collection_name)
        data.delete(collection_name)
      end

      # Clears the data store.
      #
      # Mainly used for rolling back the data store for tests.
      #
      # @return [Hash] the data store
      def self.clear
        data.clear
      end

      # Alias to Mince::HashyDb::DataStore.data=
      def self.set_data(hash)
        DataStore.set_data hash
      end

      # Alias to Mince::HashyDb::DataStore.data
      def self.data
        DataStore.data
      end
    end

    module PrimaryKey
      def self.name
        Config.primary_key
      end

      def self.generate(salt)
        Digest::SHA256.hexdigest("#{Time.now}#{salt}")[0..6]
      end
    end
  end
end
