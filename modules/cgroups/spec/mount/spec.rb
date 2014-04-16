require 'spec_helper'

describe package('cgroup-bin') do
  it { should be_installed }
end

describe file('/sys/fs/cgroup/cpu') do
  it { should be_directory }
end

describe file('/sys/fs/cgroup/cpuacct') do
  it { should be_directory }
end

describe file('/sys/fs/cgroup/cpuset') do
  it { should be_directory }
end

describe file('/sys/fs/cgroup/memory') do
  it { should be_directory }
end

describe file('/sys/fs/cgroup/devices') do
  it { should be_directory }
end
