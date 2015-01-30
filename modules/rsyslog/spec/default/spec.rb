require 'spec_helper'

describe file('/etc/rsyslog.conf') do
  it { should be_file }
  its(:content) { should match /\$FileCreateMode 0707/ }
end

describe package('rsyslog') do
  it { should be_installed }
end

describe service('rsyslog') do
  it { should be_running }
end

describe file('/var/log/syslog') do
  it { should be_file }
  it { should be_mode 707 }
end
