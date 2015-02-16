require 'spec_helper'

describe 'php5' do

  describe package('php5-cli') do
    it { should be_installed }
  end

  describe file('/etc/php5/cli/php.ini') do
    its(:content) { should match /memory_limit = 8G/ }
  end
end
