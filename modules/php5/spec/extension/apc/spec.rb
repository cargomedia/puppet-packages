require 'spec_helper'

describe command('php --ri apc') do
  it { should return_exit_status 0 }
end

describe file('/var/log/php/error.log') do
  its(:content) { should_not match /Warning.*apc.*already loaded/ }
end

describe command('php --ri apc') do
  its(:stdout) { should match /apc.cache_by_default => Off/ }
end
