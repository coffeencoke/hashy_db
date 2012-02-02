require_relative '../../examples/guitar'

describe Guitar do
  let(:attrs) { { brand: 'Gibson', price: 3399.99, type: 'Les Paul', color: 'Mahogany' } }
  
  subject { described_class.new(attrs)}

  its(:brand){ should == attrs[:brand] }
  its(:price){ should == attrs[:price] }
  its(:type){ should == attrs[:type] }
  its(:color){ should == attrs[:color] }
end