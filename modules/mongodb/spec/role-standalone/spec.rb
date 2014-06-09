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
