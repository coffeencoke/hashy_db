require_relative '../../examples/guitar'

describe Guitar do
  subject { described_class.new(brand: 'Gibson')}

  it 'has a brand' do
    subject.brand.should == 'Gibson'
  end
end