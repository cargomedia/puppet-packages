require 'spec_helper'

describe file('/etc/rsyslog.conf') do
  it { should be_file }
end

describe package('rsyslog') do
  it { should be_installed }
end

describe service('rsyslog') do
  it { should be_running }
end
