require_relative '../../lib/hashy_db'
require_relative '../support/shared_examples/mince_interface_example'

describe 'Mince Interface with HashyDb' do
  let(:expected_primary_key) { :id }

  before do
    Mince::Config.interface = Mince::HashyDb::Interface
  end

  it_behaves_like 'a mince interface'
end
