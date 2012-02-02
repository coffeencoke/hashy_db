require 'digest'
require_relative '../../../lib/hashy_db/data_store'

shared_examples_for 'a data model' do
  let(:mock_data_store) { mock 'data store data model' }

  before do
    HashyDB::DataStore.stub(:instance => mock_data_store)
  end

  describe "storing a data model" do
    let(:current_time) { mock 'current time' }
    let(:mock_data_model_string_rep) { mock 'data model string representation used for generating an id' }
    let(:data_model_id) { full_data_model_id[0..6] }
    let(:full_data_model_id) { '1234567891423456789' }
    let(:mock_data_model) { mock 'a data model', data_field_attributes }

    before do
      Time.stub(:current => current_time)
      Digest::SHA256.stub(:hexdigest => full_data_model_id)
      mock_data_store.stub(:add)
    end

    it 'creates a unique hash for the id' do
      Digest::SHA256.should_receive(:hexdigest).with("#{current_time}#{mock_data_model}").and_return(full_data_model_id)

      described_class.store(mock_data_model)
    end

    it 'adds the data model to the db store' do
      mock_data_store.should_receive(:add).with(collection_name, {id: data_model_id}.merge(data_field_attributes))

      described_class.store(mock_data_model)
    end
  end

  describe "updating a data model" do
    let(:data_model_id) { '1234567' }
    let(:mock_model) { mock 'a model', {:id => data_model_id}.merge(data_field_attributes) }

    before do
      mock_data_store.stub(:replace)
    end

    it 'replaces the data model in the db store' do
      mock_data_store.should_receive(:replace).with(collection_name, {id: data_model_id}.merge(data_field_attributes))

      described_class.update(mock_model)
    end
  end

  describe "pushing a value to an array for a data model" do
    let(:data_model_id) { '1234567' }

    it 'replaces the data model in the db store' do
      mock_data_store.should_receive(:push_to_array).with(collection_name, :id, data_model_id, :array_field, 'some value')

      described_class.push_to_array(data_model_id, :array_field, 'some value')
    end
  end

  describe "getting all data models with a specific value for a field" do
    let(:mock_data_models) { mock 'data models in the data store' }
    subject { described_class.array_contains(:some_field, 'some value') }

    it 'returns the stored data models with the requested field / value' do
      mock_data_store.should_receive(:array_contains).with(collection_name, :some_field, 'some value').and_return(mock_data_models)

      subject.should == mock_data_models
    end
  end

  describe "removing a value from an array for a data model" do
    let(:data_model_id) { '1234567' }

    it 'removes the value from the array' do
      mock_data_store.should_receive(:remove_from_array).with(collection_name, :id, data_model_id, :array_field, 'some value')

      described_class.remove_from_array(data_model_id, :array_field, 'some value')
    end
  end

  describe 'getting all of the data models' do
    let(:mock_data_models) { mock 'data models in the data store' }

    it 'returns the stored data models' do
      mock_data_store.should_receive(:get).with(collection_name).and_return(mock_data_models)

      described_class.all.should == mock_data_models
    end
  end

  describe "getting all the data fields by a parameter hash" do
    let(:mock_data_models) { mock 'some data model'}
    let(:sample_hash) { {field1: nil, field2: 'not nil' }}

    it 'passes the hash to the DataStore' do
      mock_data_store.should_receive(:get_by_params).with(collection_name, sample_hash).and_return(mock_data_models)
      
      described_class.all_by_fields(sample_hash).should == mock_data_models
    end
  end

  describe "getting a record by a set of key values" do
    let(:mock_data_model) { mock 'some data model' }
    let(:mock_data_models) { [mock_data_model]}
    let(:sample_hash) { {field1: nil, field2: 'not nil' }}

    it 'passes the hash to the DataStore' do
      mock_data_store.should_receive(:get_by_params).with(collection_name, sample_hash).and_return(mock_data_models)

      described_class.find_by_fields(sample_hash).should == mock_data_model
    end
  end

  describe "getting all of the data models for a where a field contains any value of a given array of values" do
    let(:mock_data_models) { mock 'data models in the data store' }
    subject { described_class.containing_any(:some_field, ['value 1', 'value 2']) }

    it 'returns the stored data models' do
      mock_data_store.should_receive(:containing_any).with(collection_name, :some_field, ['value 1', 'value 2']).and_return(mock_data_models)

      subject.should == mock_data_models
    end
  end

  describe "getting all data models with a specific value for a field" do
    let(:mock_data_models) { mock 'data models in the data store' }
    subject { described_class.all_by_field(:some_field, 'some value') }

    it 'returns the stored data models with the requested field / value' do
      mock_data_store.should_receive(:get_all_for_key_with_value).with(collection_name, :some_field, 'some value').and_return(mock_data_models)

      subject.should == mock_data_models
    end
  end

  describe 'getting a specific data model' do
    let(:mock_data_model) { mock 'data_model', :id => 'id' }

    it 'returns the data model from the data store' do
      mock_data_store.should_receive(:get_one).with(collection_name, :id, mock_data_model.id).and_return(mock_data_model)

      described_class.get_one(mock_data_model.id).should == mock_data_model
    end
  end
end
