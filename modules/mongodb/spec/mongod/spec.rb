require 'spec_helper'

describe package('mongodb-org-server') do
  it { should be_installed.by('apt') }
end

describe package('mongodb-org-shell') do
  it { should be_installed.by('apt') }
end

describe user('mongodb') do
  it { should exist }
  it { should belong_to_group 'mongodb' }
end

describe service('mongod_server') do
  it { should be_enabled }
  it { should be_running }
end

describe service('mongod$') do
  it { should_not be_enabled }
end

describe file('/etc/mongodb/mongod_server.conf') do
  its(:content) { should_not match /bind_ip/ }
end

describe file('/etc/mongod.conf') do
  it { should_not be_file }
end

describe port(28017) do
  it { should be_listening.with('tcp') }
end
