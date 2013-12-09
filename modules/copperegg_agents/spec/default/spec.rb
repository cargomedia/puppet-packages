require 'spec_helper'

describe command('/usr/bin/copperegg_agents -v') do
  it { should return_exit_status 0 }
end

describe file('/etc/init.d/copperegg_agents') do
  it { should be_file }
end

describe file('/etc/copperegg_agents.yml') do
  it { should be_file }
  its(:content) { should match 'memcached:' }
  its(:content) { should match 'apache:' }
end
