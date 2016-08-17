require 'spec_helper'

describe 'php5::extension::opcache' do

  describe command('php --ri "Zend OPcache"') do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should_not match /Zend OPcache.+already loaded/ }
    its(:stdout) { should match /opcache.enable => On/ }
    its(:stdout) { should match /opcache.max_accelerated_files => 555/ }
  end
end
