require 'spec_helper'
describe 'consul_template' do

  context 'with defaults for all parameters' do
    it { should contain_class('consul_template') }
  end
end
