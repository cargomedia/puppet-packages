require 'spec_helper'

describe command('cgget puppet-agent-daemon --all') do
  it { should return_exit_status 0 }
  its(:stdout) { should match /cpu.shares: 50/ }
end
