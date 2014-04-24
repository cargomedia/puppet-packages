require 'spec_helper'

# just waiting for mongod start up
describe command('sleep 15') do
  it { should return_exit_status 0 }
end

describe package('mongodb-org-server') do
  it { should be_installed.by('apt').with_version('2.6.0') }
end

describe package('mongodb-org-shell') do
  it { should be_installed.by('apt').with_version('2.6.0') }
end

describe user('mongodb') do
  it { should exist }
  it { should belong_to_group 'mongodb' }
end

describe service('mongod_standalone') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/mongodb/mongod_standalone.conf') do
  its(:content) { should match /bind_ip = 127.0.0.1/ }
end

describe port(27017) do
  it { should be_listening.with('tcp') }
end

describe port(28017) do
  it { should be_listening.with('tcp') }
end

describe command('mongo --version') do
  its(:stdout) { should match /version.*2.6.0/ }
end
