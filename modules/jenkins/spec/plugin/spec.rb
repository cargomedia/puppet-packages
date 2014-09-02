require 'spec_helper'

describe file('/var/lib/jenkins/plugins/ssh-agent.hpi') do
  it { should be_file }
  it { should be_owned_by 'jenkins' }
end

describe file('/var/lib/jenkins/plugins/git-client.hpi') do
  it { should be_file }
  it { should be_owned_by 'jenkins' }
end

describe command('curl http://localhost:8080/pluginManager/installed') do
  let(:pre_command) { 'sleep 10' }
  its(:stdout) { should match /ssh-agent/ }
  its(:stdout) { should match /git-client/ }
end
