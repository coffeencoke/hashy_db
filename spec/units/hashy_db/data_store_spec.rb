require_relative '../../../lib/hashy_db/data_store'

describe Mince::HashyDb::DataStore do
  it 'has no data by default' do
    described_class.data.should == {}
  end

  it 'can add data' do
    data = mock
    described_class.set_data(data)

    described_class.data.should == data
  end

  it 'can return a collection' do
    data = mock
    described_class.set_data({ some_collection: data })

    described_class.collection(:some_collection).should == data
  end
end
