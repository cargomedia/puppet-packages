require 'spec_helper'

describe command('php --ri apcu') do
  it { should return_exit_status 0 }
  its(:stdout) { should match /apc.shm_size => 12M/ }
  its(:stdout) { should match /apc.enable_cli => Off/ }
end
