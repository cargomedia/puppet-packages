require 'spec_helper'

describe 'jenkins::plugin' do

  describe file('/var/lib/jenkins/plugins/git.hpi') do
    it { should be_file }
    it { should be_owned_by 'jenkins' }
  end

  describe file('/var/lib/jenkins/plugins/pagerduty.hpi') do
    it { should be_file }
    it { should be_owned_by 'jenkins' }
  end

  # Wait for jenkins to start up
  describe command('timeout --signal=9 30 bash -c "while ! (curl -s http://localhost:8080/ | grep -q "Dashboard"); do sleep 0.5; done"') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/var/log/jenkins/jenkins.log') do
    its(:content) { should_not match('Failed Loading plugin') }
  end

  describe command('curl -s http://localhost:8080/pluginManager/installed') do
    its(:stdout) { should match /git/ }
    its(:stdout) { should match /pagerduty/ }
  end

end
