require 'spec_helper'

describe 'jenkins server' do

  describe package('jenkins') do
    it { should be_installed }
  end

  # Wait for jenkins to start up
  describe command('timeout --signal=9 30 bash -c "while ! (curl -s http://localhost:1234/ | grep -q "Dashboard"); do sleep 0.5; done"') do
    its(:exit_status) { should eq 0 }
  end

  # Make sure only 1 port is open (HTTP)
  describe command('netstat -lnp | grep java | wc -l') do
    its(:stdout) { should match '1' }
  end

  describe port(1234) do
    it { should be_listening }
  end

  describe file('/var/lib/jenkins/config.xml') do
    its(:content) { should match '<numExecutors>2</numExecutors>' }
  end

  describe file('/var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml') do
    its(:content) { should match '<adminAddress>admin@example.com</adminAddress>' }
  end
end
