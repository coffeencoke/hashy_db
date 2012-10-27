require_relative '../../lib/hashy_db'
require 'mince/shared_examples/interface_example'

describe 'Mince Interface with HashyDb' do
  before do
    Mince::Config.interface = Mince::HashyDb::Interface
  end

  it_behaves_like 'a mince interface'
end
