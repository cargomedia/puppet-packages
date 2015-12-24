require 'spec_helper'

describe 'coturn' do

  describe package('coturn') do
    it { should be_installed }
  end

  describe service('coturn') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(5766) do
    it { should be_listening }
  end

  describe command('/var/log/coturn/turnserver.log') do
    it { should match /Server/}
  end
end
