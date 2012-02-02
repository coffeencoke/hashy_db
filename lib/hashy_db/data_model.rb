# SRP: Interface to read and write to and from the data store class for a specific collection

require_relative '../hashy_db/data_store'

require 'digest'
require 'active_support/concern'

module HashyDB
  module DataModel
    extend ActiveSupport::Concern

    included do
      attr_reader :id, :model
    end

    module ClassMethods
      def data_fields(*fields)
        create_data_fields(*fields) if fields.any?
        @data_fields
      end

      def data_collection(collection_name = nil)
        set_data_collection(collection_name) if collection_name
        @data_collection
      end

      def store(model)
        new(model).tap do |p|
          p.add_to_data_store
        end.id
      end

      def update(model)
        new(model).tap do |p|
          p.replace_in_data_store
        end
      end

      def remove_from_array(id, field, value)
        DataStore.instance.remove_from_array(data_collection, :id, id, field, value)
      end

      def push_to_array(id, field, value)
        DataStore.instance.push_to_array(data_collection, :id, id, field, value)
      end

      def get_one(id)
        DataStore.instance.get_one(data_collection, :id, id)
      end

      def all
        DataStore.instance.get(data_collection)
      end

      def all_by_field(field, value)
        DataStore.instance.get_all_for_key_with_value(data_collection, field, value)
      end

      def all_by_fields(hash)
        DataStore.instance.get_by_params(data_collection, hash)
      end

      def find_by_fields(hash)
        all_by_fields(hash).first
      end

      def containing_any(field, values)
        DataStore.instance.containing_any(data_collection, field, values)
      end

      def array_contains(field, value)
        DataStore.instance.array_contains(data_collection, field, value)
      end

      private

      def set_data_collection(collection_name)
        @data_collection = collection_name
      end

      def create_data_fields(*fields)
        attr_accessor *fields
        @data_fields = fields
      end
    end

    def initialize(model)
      @model = model
      set_data_field_values
      set_id
    end

    def data_fields
      self.class.data_fields
    end

    def data_collection
      self.class.data_collection
    end

    def add_to_data_store
      DataStore.instance.add(data_collection, attributes)
    end

    def replace_in_data_store
      DataStore.instance.replace(data_collection, attributes)
    end

    private

    def attributes
      { id: id }.merge(data_field_attributes)
    end

    def data_field_attributes
      {}.tap do |hash|
        data_fields.each do |field|
          hash[field] = self.send(field)
        end
      end
    end

    def set_id
      @id = if(model.respond_to?(:id) && model.id)
        model.id
      else
        new_hash(Time.current)
      end
    end

    def new_hash(salt)
      Digest::SHA256.hexdigest("#{salt}#{model}")[0..6]
    end

    def set_data_field_values
      data_fields.each { |field| set_data_field_value(field) }
    end

    def set_data_field_value(field)
      self.send("#{field}=", model.send(field)) if field_exists?(field)
    end

    def field_exists?(field)
      model.respond_to?(field) && !model.send(field).nil?
    end
  end
end