# SRP: Model with implementation on how to store each collection in a data store
require 'singleton'
require 'active_support/core_ext/module/delegation'
require 'digest'

module HashyDb
  class DataStore
    include Singleton

    def self.primary_key_identifier
      :id
    end

    def self.generate_unique_id(salt)
      Digest::SHA256.hexdigest("#{Time.current.utc}#{salt}")[0..6]
    end

    def add(collection_name, hash)
      find_all(collection_name) << hash
    end

    def replace(collection_name, hash)
      collection = find_all(collection_name)
      index = collection.index{ |object| object[:id] == hash[:id] }
      collection[index] =  hash
    end

    def update_field_with_value(collection_name, primary_key_value, field_name, new_value)
      find(collection_name, :id, primary_key_value)[field_name] = new_value
    end

    def get_all_for_key_with_value(collection_name, key, value)
      find_all(collection_name).select { |a| a[key] == value }
    end

    def get_for_key_with_value(collection_name, key, value)
      get_all_for_key_with_value(collection_name, key, value)[0]
    end

    def get_by_params(collection_name, hash)
      find_all(collection_name).select do |record|
        hash.all? do |k,v|
          if record[k].is_a?(Array)
            record[k].include?(v)
          else
            record[k] == v
          end
        end
      end
    end

    def find_all(collection_name)
      data_store[collection_name] ||= []
    end

    def find(collection_name, key, value)
      find_all(collection_name).find { |x| x[key] == value }
    end

    def push_to_array(collection_name, identifying_key, identifying_value, array_key, value_to_push)
      record = find(collection_name, identifying_key, identifying_value)
      if (record[array_key])
        record[array_key] << value_to_push
      else
        record[array_key] = [value_to_push]
      end
      record[array_key].uniq!
    end

    def remove_from_array(collection_name, identifying_key, identifying_value, array_key, value_to_pop)
      record = find(collection_name, identifying_key, identifying_value)
      record[array_key].reject! { |x| x == value_to_pop }
    end

    def containing_any(collection_name, key, values)
      find_all(collection_name).select do |x|
        if x[key].is_a?(Array)
          (x[key] & values).any?
        else
          values.include?(x[key])
        end
      end
    end

    def array_contains(collection_name, key, value)
      find_all(collection_name).select do |x|
        x[key] && x[key].include?(value)
      end
    end

    def clear
      data_store.clear
    end

    def insert(collection_name, data)
      data_store[collection_name] = data
    end

    def set_data_store(hash)
      @data_store = hash
    end

    private

    def data_store
      @data_store ||= ::DB_HASH
    end
  end
end
