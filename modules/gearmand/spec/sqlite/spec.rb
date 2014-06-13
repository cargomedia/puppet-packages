require 'spec_helper'

describe file('/var/log/gearman-job-server/gearman-persist.sqlite3') do
  it { should be_file }
end

describe process("gearmand") do
  it { should be_running }
  its(:args) { should match /-q libsqlite3/ }
end
