require 'spec_helper'
describe 'hanaconfig' do
  context 'with default values for all parameters' do
    it { should contain_class('hanaconfig') }
  end
end
