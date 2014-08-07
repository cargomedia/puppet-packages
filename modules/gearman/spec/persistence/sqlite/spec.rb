require 'spec_helper'

describe file('/var/log/gearman-job-server/gearman-persist.sqlite3') do
  it { should be_file }
  it { should be_owned_by 'gearman'}
end

describe file('/etc/default/gearman-job-server') do
  it { should be_file }
  its(:content) { should match /-q libsqlite3/ }
end

describe service('gearman-job-server') do
  it { should be_running }
end

describe port(4730) do
  it { should be_listening }
end

describe command('lsof | grep gearmand | grep -q gearman-persist.sqlite3') do
  it { should return_exit_status 0 }
end
