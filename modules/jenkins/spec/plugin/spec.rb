require 'spec_helper'

describe 'jenkins::plugin' do

  # Wait for jenkins to start up
  describe command('timeout --signal=9 30 bash -c "while ! (curl -s http://localhost:8080/ | grep -q "Dashboard"); do sleep 0.5; done"') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/var/log/jenkins/jenkins.log') do
    its(:content) { should_not match('Failed Loading plugin') }
    its(:content) { should_not match('SEVERE:') }
  end

  describe command('curl -s http://localhost:8080/pluginManager/installed') do
    its(:stdout) { should match /pagerduty/ }
    its(:stdout) { should match /git/ }
    its(:stdout) { should match /github/ }
    its(:stdout) { should match /ghprb/ }
    its(:stdout) { should match /ansicolor/ }
    its(:stdout) { should match /embeddable-build-status/ }
  end

end
