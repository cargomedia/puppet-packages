require 'spec_helper'

describe 'coturn' do

  describe package('coturn') do
    it { should be_installed }
  end

  describe service('coturn') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(3478) do
    it { should be_listening }
  end
end
