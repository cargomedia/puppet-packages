require 'spec_helper'

describe user('bipbip') do
  it { should exist }
end

describe command('/usr/local/bin/bipbip -v') do
  it { should return_exit_status 0 }
end

describe service('bipbip') do
  it { should be_enabled }
end

describe file('/etc/monit/conf.d/bipbip') do
  it { should be_file }
end

describe file('/etc/init.d/bipbip') do
  it { should be_file }
end

describe file('/etc/bipbip/config.yml') do
  it { should be_file }
  its(:content) { should match /include:.*services.d/ }
end

describe file('/etc/bipbip/services.d') do
  it { should be_directory }
end

describe file('/etc/bipbip/services.d/memcache.yml') do
  it { should be_file }
  its(:content) { should match /plugin:.*memcached/ }
  its(:content) { should match /hostname:.*localhost/ }
  its(:content) { should match /port:.*6379/ }
end

describe command('/etc/init.d/bipbip status') do
  it { should return_exit_status 0 }
end

describe file('/etc/logrotate.d/bipbip') do
  it { should be_file }
end

describe command('logrotate -d /etc/logrotate.d/bipbip') do
  it { should return_exit_status 0 }
end

describe command('logrotate -f /etc/logrotate.d/bipbip') do
  it { should return_exit_status 0 }
end

describe command('monit restart bipbip && sleep 5') do
  it { should return_exit_status 0 }
end

describe command('logrotate -f /etc/logrotate.d/bipbip') do
  it { should return_exit_status 0 }
end

describe file('/var/log/bipbip/bipbip.log.2.gz') do
  it { should be_file }
end
