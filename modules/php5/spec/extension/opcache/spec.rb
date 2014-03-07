require 'spec_helper'

describe command('php --ri "Zend OPcache"') do
  it { should return_exit_status 0 }
  its(:stdout) { should match /opcache.enable => On/ }
end
