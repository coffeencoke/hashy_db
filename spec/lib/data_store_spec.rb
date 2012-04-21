require_relative '../../lib/hashy_db/data_store'

describe HashyDb::DataStore do
  subject { HashyDb::DataStore.instance }

  let(:data1) { {id: 1, field_1: 'value 1', field_2: 3, field_3: [1, 2, 3], shared_between_1_and_2: 'awesome_value', :some_array => [1, 2, 3, 4], :shared_between_1_and_3 => 'same'} }
  let(:data2) { {id: 2, field_1: 'value 1.2', field_2: 6, shared_between_1_and_2: 'awesome_value', :some_array => [4, 5, 6], :shared_between_1_and_3 => 'not same'}  }
  let(:data3) { {id: 3, field_1: 'value 3', field_2: 9, shared_between_1_and_2: 'not the same as 1 and 2', :some_array => [1, 7], :shared_between_1_and_3 => 'same'}  }

  before do
    subject.set_data_store({})

    subject.insert(:some_collection, [data1, data2, data3])
  end

  it 'has a primary key identifier' do
    described_class.primary_key_identifier.should == :id
  end

  describe "Generating a primary key" do
    let(:data_model_id) { full_data_model_id[0..6] }
    let(:full_data_model_id) { '1234567891423456789' }
    let(:utc) { mock 'utc'}
    let(:time) { mock 'time', :utc => utc}
    let(:salt) { mock 'salt to ensure uniqeness' }

    before do
      Digest::SHA256.stub(:hexdigest => full_data_model_id)
      Time.stub(:current => time)
    end

    it 'should create a reasonably unique id' do
      Digest::SHA256.should_receive(:hexdigest).with("#{utc}#{salt}").and_return(full_data_model_id)

      described_class.generate_unique_id(salt).should == data_model_id
    end
  end

  it 'can write and read data to and from a collection' do
    data4 = {id: 3, field_1: 'value 3', field_2: 9, shared_between_1_and_2: 'not the same as 1 and 2', :some_array => [1, 7]}

    subject.add(:some_collection, data4)
    subject.find_all(:some_collection).should == [data1, data2, data3, data4]
  end

  it 'can replace a record' do
    data2[:field_1] = 'value modified'
    subject.replace(:some_collection, data2)

    subject.find(:some_collection, :id, 2)[:field_1].should == 'value modified'
  end

  it 'can update a field with a value on a specific record' do
    subject.update_field_with_value(:some_collection, 3, :field_2, '10')
    
    subject.find(:some_collection, :id, 3)[:field_2].should == '10'
  end

  it 'can get one document' do
    subject.find(:some_collection, :field_1, 'value 1').should == data1
    subject.find(:some_collection, :field_2, 6).should == data2
  end

  it 'can clear the data store' do
    subject.clear

    subject.find_all(:some_collection).should == []
  end

  it 'can get all records of a specific key value' do
    subject.get_all_for_key_with_value(:some_collection, :shared_between_1_and_2, 'awesome_value').should == [data1, data2]
  end

  it 'can get all records where a value includes any of a set of values' do
    subject.containing_any(:some_collection, :some_array, []).should == []
    subject.containing_any(:some_collection, :some_array, [7, 2, 3]).should == [data1, data3]
    subject.containing_any(:some_collection, :id, [1, 2, 5]).should == [data1, data2]
  end

  it 'can get all records where the array includes a value' do
    subject.array_contains(:some_collection, :some_array, 1).should == [data1, data3]
    subject.array_contains(:some_collection, :some_array_2, 1).should == []
  end

  it 'can push a value to an array for a specific record' do
    subject.push_to_array(:some_collection, :id, 1, :field_3, 'add to existing array')
    subject.push_to_array(:some_collection, :id, 1, :new_field, 'add to new array')

    subject.find(:some_collection, :id, 1)[:field_3].should include('add to existing array')
    subject.find(:some_collection, :id, 1)[:new_field].should == ['add to new array']
  end

  it 'can remove a value from an array for a specific record' do
    subject.remove_from_array(:some_collection, :id, 1, :field_3, 2)

    subject.find(:some_collection, :id, 1)[:field_3].should_not include(2)
  end

  it 'can get all records that match a given set of keys and values' do
    records = subject.get_by_params(:some_collection, field_1: 'value 1', shared_between_1_and_2: 'awesome_value')
    records.size.should be(1)
    records.first[:id].should == 1
    subject.find_all(:some_collection).size.should == 3
  end

  it 'can get a record for a specific key and value' do
    subject.get_for_key_with_value(:some_collection, :field_1, 'value 1').should == data1
  end

  it 'can get record using get_by_params when one of the key contains array values' do
    records = subject.get_by_params(:some_collection, some_array: 1, shared_between_1_and_3: 'same')
    records.size.should be(2)
    records.first[:id].should == 1
    records.last[:id].should == 3
  end
end
