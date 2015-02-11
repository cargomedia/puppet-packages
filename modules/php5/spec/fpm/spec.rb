require 'spec_helper'

describe 'php5::fpm' do

  describe package('php5-fpm') do
    it { should be_installed }
  end

  describe command('monit summary | grep php5-fpm') do
    its(:exit_status) { should eq 0 }
  end

  describe command('logrotate -f /etc/logrotate.d/php5-fpm') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/var/log/php5-fpm/php5-fpm.log.1') do
    it { should be_file }
  end

  describe file('/var/log/php5-fpm/php5-fpm.log') do
    its(:content) { should match /error log file re-opened/ }
  end

  describe file('/etc/bipbip/services.d/logparser-php5-fpm.yml') do
    it { should be_file }
  end
end
