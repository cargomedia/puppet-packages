require 'spec_helper'

describe command('cgconfigparser -l /etc/cgconfig.conf') do
  it { should return_exit_status 0 }
end

describe command('cgexec -g cpu:puppet uname -ar') do
  it { should return_exit_status 0 }
  its(:stdout) { should match /Debian/ }
end

describe command('cgexec -g cpu:vagrant uname -ar') do
  it { should return_exit_status 0 }
  its(:stdout) { should match /Debian/ }
end

describe command('cgget puppet --all') do
  it { should return_exit_status 0 }
  its(:stdout) { should match /cpu.shares: 1024/ }
  its(:stdout) { should match /cpuset.mems: 0/ }
  its(:stdout) { should match /cpuset.cpus: 0/ }
end

describe command('cgget vagrant --all') do
  it { should return_exit_status 0 }
  its(:stdout) { should match /cpu.shares: 200/ }
  its(:stdout) { should match /cpuset.mems: 0/ }
  its(:stdout) { should match /cpuset.cpus: 0/ }
end
