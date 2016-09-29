require 'spec_helper'

describe 'puppetserver::puppetdb' do

  describe package('puppetdb') do
    it { should be_installed }
  end

  describe service('puppetdb') do
    it { should be_running }
    it { should be_enabled }
  end

# Wait for puppetdb to start up
  describe command('timeout --signal=9 30 bash -c "while ! (netstat -altp |grep -q \'java\'); do sleep 0.5; done"') do
    its(:exit_status) { should eq 0 }
  end

  describe port(8080) do
    it { should be_listening }
  end

  describe port(8081) do
    it { should be_listening }
  end

  describe service('puppetdb') do
    it { should be_enabled }
    it { should be_running }
  end

end
