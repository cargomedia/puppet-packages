require 'spec_helper'

describe command('php --ri apcu') do
  it { should return_exit_status 0 }
  its(:stdout) { should match /apc.shm_size => 12M/ }
end

describe command('php -r "apc_store(\"foo\", 12); echo apc_fetch(\"foo\");"') do
  its(:stdout) { should eq('12') }
end

describe file('/var/log/php/error.log') do
  its(:content) { should_not match /Warning.*apcu.*already loaded/ }
end
