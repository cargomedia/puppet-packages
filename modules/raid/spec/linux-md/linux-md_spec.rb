require 'spec_helper'

describe package('mdadm') do
  it { should be_installed }
end

describe file('/etc/mdadm/mdadm.conf') do
  it { should be_file }
end

describe file('/etc/monit/conf.d/mdadm-status') do
  it { should be_file }
end

describe file('/proc/mdstat') do
  it { should be_readible }
end