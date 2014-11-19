require 'spec_helper'

describe command('ps -eo pid,nice | grep $(cat /var/run/puppet/agent.pid)') do
  it { should return_exit_status 0 }
  its(:stdout) { should match /19/ }
end
