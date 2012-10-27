require_relative '../../../lib/hashy_db/config'

describe Mince::HashyDb::Config do
  it 'it knows what to use for the primary key of each record' do
    described_class.primary_key.should == :id
  end
end
