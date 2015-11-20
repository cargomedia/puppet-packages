require 'spec_helper'

describe 'coturn' do

  describe user('coturn') do
    it { should exist }
  end

  describe service('coturn') do
    it { should be_enabled }
    it { should be_running }
  end

end
