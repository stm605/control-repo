require 'spec_helper'
describe 'sapmount' do
  context 'with default values for all parameters' do
    it { should contain_class('sapmount') }
  end
end
