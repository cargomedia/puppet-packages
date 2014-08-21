require 'spec_helper'

describe package('jenkins') do
  it { should be_installed }
end

describe command('monit summary') do
  its(:stdout) { should match /Process 'jenkins'/ }
end

describe port(1234) do
  it { should be_listening }
end

describe file('/var/lib/jenkins/config.xml') do
  its(:content) { should match '<numExecutors>2</numExecutors>' }
end

# Make sure only 1 port is open (HTTP)
describe command('netstat -lnp | grep java | wc -l') do
  let(:pre_command) { 'sleep 10' } # Let jenkins start up
  its(:stdout) { should match '1' }
end
