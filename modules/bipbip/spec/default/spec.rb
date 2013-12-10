require 'spec_helper'

describe user('bipbip') do
  it { should exist }
end

describe command('/usr/bin/bipbip -v') do
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
