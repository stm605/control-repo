require 'spec_helper'
describe 'saphana' do

  context 'with default values for all parameters' do
    it { should contain_class('saphana') }
  end
end
