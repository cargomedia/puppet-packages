require 'spec_helper'

describe 'puppet::agent nice' do

  describe service('puppet') do
    it { should be_enabled }
    it { should be_running }
  end

  describe command('ps -eo pid,nice | grep $(cat /var/run/puppet/agent.pid)') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /-19/ }
  end
end
