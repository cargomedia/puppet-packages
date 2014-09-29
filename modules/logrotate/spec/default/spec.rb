require 'spec_helper'

describe package('logrotate') do
  it { should be_installed }
end

describe file('/etc/cron.daily/logrotate') do
  it { should be_file }
  it { should be_executable }
end
