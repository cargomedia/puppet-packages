require 'spec_helper'

describe command('cgget puppet-agent-daemon --all') do
  it { should return_exit_status 0 }
  its(:stdout) { should match /cpu.shares: 50/ }
end

describe command('grep -q $(pgrep --full "/usr/bin/ruby /usr/bin/puppet agent") /sys/fs/cgroup/puppet-agent-daemon/tasks') do
  it { should return_exit_status 0 }
end
