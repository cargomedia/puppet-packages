require 'spec_helper'

describe package('cgroup-bin') do
  it { should be_installed }
end

describe service('cgconfig-apply') do
  it { should be_enabled }
end

describe file('/etc/cgconfig.conf') do
  it { should be_file }
end

describe file('/sys/fs/cgroup') do
  it { should be_directory }
  it { should be_mounted }
end
