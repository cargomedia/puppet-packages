require 'spec_helper'

describe package('mdadm') do
  it { should be_installed }
end

describe file('/etc/mdadm/mdadm.conf') do
  it { should be_file }
end

describe file('/proc/mdstat') do
  it { should be_readable }
end

describe command('monit summary') do
  its(:stdout) { should match /Process 'mdadm-status'/ }
end
