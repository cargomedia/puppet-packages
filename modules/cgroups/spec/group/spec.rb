require 'spec_helper'

describe package('cgroup-bin') do
  it { should be_installed }
end

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
