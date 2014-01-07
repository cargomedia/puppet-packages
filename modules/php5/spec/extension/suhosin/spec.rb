require 'spec_helper'

describe package('php5-suhosin') do
  it { should be_installed }
end

describe 'PHP config parameters' do
  context  php_config('suhosin.executor.include.whitelist') do
    its(:value) { should eq 'phar' }
  end
end

describe file('/etc/php5/conf.d/suhosin.ini') do
  it { should be_file }
  its(:content) { should match /extension = suhosin.so/ }
end
