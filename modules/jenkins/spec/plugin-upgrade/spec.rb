require 'spec_helper'

describe 'jenkins::plugin-upgrade' do

  # Wait for jenkins to start up
  describe command('timeout --signal=9 30 bash -c "while ! (curl -s http://localhost:8080/ | grep -q "Dashboard"); do sleep 0.5; done"') do
    its(:exit_status) { should eq 0 }
  end

  describe command('cat /var/lib/jenkins/plugins/ssh-agent/META-INF/MANIFEST.MF') do
    its(:stdout) { should match /Plugin-Version: 1.7/ }
  end

end
