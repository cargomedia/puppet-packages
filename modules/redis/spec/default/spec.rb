require 'spec_helper'

describe port(6379) do
  it { should be_listening }
end

describe command('sysctl vm.overcommit_memory') do
  it { should return_exit_status 0 }
  its(:stdout) { should match /vm.overcommit_memory = 0/ }
end
