require 'spec_helper'

describe package('php5-fpm') do
  it { should be_installed }
end

describe command('monit summary | grep php5-fpm') do
  it { should return_exit_status 0 }
end

describe command('logrotate -f /etc/logrotate.d/php5-fpm') do
  it { should return_exit_status 0 }
end

describe file('/var/log/php5-fpm/php5-fpm.log.1') do
  it { should be_file }
end

describe file('/var/log/php5-fpm/php5-fpm.log') do
  its(:content) { should match /error log file re-opened/ }
end
