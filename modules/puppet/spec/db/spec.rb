require 'spec_helper'

describe 'puppetdb' do

  describe package('puppetdb') do
    it { should be_installed }
  end

# Wait for puppetdb to start up
  describe command('timeout --signal=9 30 bash -c "while ! (grep -q \'PuppetDB version\' /var/log/puppetdb/puppetdb.log); do sleep 0.5; done"') do
    its(:exit_status) { should eq 0 }
  end

  describe port(8080) do
    it { should be_listening }
  end

  describe port(8081) do
    it { should be_listening }
  end
end
