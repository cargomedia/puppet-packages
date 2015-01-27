require 'spec_helper'

describe service('puppet') do
  it { should be_enabled }
  it { should be_running }
end

describe command('ps -eo pid,nice | grep $(cat /var/run/puppet/agent.pid)') do
  it { should return_exit_status 0 }
  its(:stdout) { should match /-19/ }
end
