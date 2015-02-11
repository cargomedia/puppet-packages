require 'spec_helper'

describe 'redis' do

  describe port(6379) do
    it { should be_listening }
  end

  describe command('sysctl vm.overcommit_memory') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /vm.overcommit_memory = 1/ }
  end

  describe command('monit summary') do
    its(:stdout) { should match /redis/ }
  end
end
