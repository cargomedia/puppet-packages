require 'spec_helper'

describe 'php5::extension::opcache' do

  describe command('php --ri "Zend OPcache"') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /opcache.enable => On/ }
  end
end
