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

describe service('mongod_server') do
  it { should be_enabled }
  it { should be_running }
  it { should be_monitored_by('monit') }
end

describe port(28017) do
  it { should be_listening.with('tcp') }
end

describe command('mongo --version') do
  its(:stdout) { should match /version.*2.6.0/ }
end
