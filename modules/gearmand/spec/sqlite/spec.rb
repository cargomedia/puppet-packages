require 'spec_helper'

describe file('/var/log/gearman-job-server/gearman-persist.sqlite3') do
  it { should be_file }
  it { should be_owned_by 'gearman'}
end

describe process("gearmand") do
  it { should be_running }
end

describe command('lsof | grep gearmand | grep -q gearman-persist.sqlite3') do
  it { should return_exit_status 0 }
end
