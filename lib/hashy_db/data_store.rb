# SRP: Model with implementation on how to store each collection in a data store
require 'singleton'
require 'active_support/core_ext/module/delegation'

module HashyDB
  class DataStore
    include Singleton

    attr_writer :data_store

    def add(collection_name, hash)
      get(collection_name) << hash
    end

    def replace(collection_name, hash)
      collection = get(collection_name)
      index = collection.index{ |object| object[:id] == hash[:id] }
      collection[index] =  hash
    end

    def get_all_for_key_with_value(collection_name, key, value)
      get(collection_name).select { |a| a[key] == value }
    end

    def get_for_key_with_value(collection_name, key, value)
      get_all_for_key_with_value(collection_name, key, value)[0]
    end

    def get_by_params(collection_name, hash)
      get(collection_name).select do |record|
        hash.all?{|k,v| record[k] == v }
      end
    end

    def get(collection_name)
      data_store[collection_name] ||= []
    end

    def get_one(collection_name, key, value)
      get(collection_name).find { |x| x[key] == value }
    end

    def push_to_array(collection_name, identifying_key, identifying_value, array_key, value_to_push)
      record = get_one(collection_name, identifying_key, identifying_value)
      if (record[array_key])
        record[array_key] << value_to_push
      else
        record[array_key] = [value_to_push]
      end
      record[array_key].uniq!
    end

    def remove_from_array(collection_name, identifying_key, identifying_value, array_key, value_to_pop)
      record = get_one(collection_name, identifying_key, identifying_value)
      record[array_key].reject! { |x| x == value_to_pop }
    end

    def containing_any(collection_name, key, values)
      get(collection_name).select do |x|
        result = if x[key].is_a?(Array)
          (x[key] & values).any?
        else
          values.include?(x[key])
        end
      end
    end

    def array_contains(collection_name, key, value)
      get(collection_name).select do |x|
        x[key] && x[key].include?(value)
      end
    end

    def clear
      data_store.clear
    end

    def insert(collection_name, data)
      data_store[collection_name] = data
    end

    private

    def data_store
      @data_store ||= ::DB_HASH
    end
  end
end