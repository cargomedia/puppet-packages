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
