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

describe file('/etc/bipbip/services.d') do
  it { should be_directory }
end

describe user('bipbip') do
  it { should have_home_directory '/home/bipbip' }
end

yaml_files = ['/etc/bipbip/config.yml', '/etc/bipbip/services.d/memcache.yml', '/etc/bipbip/services.d/logparser.yml']

yaml_files.each do |file|
  describe command("ruby -e \"require 'psych';Psych.load_file('#{file}')\"") do
    it { should return_exit_status 0 }
  end
end

describe file(yaml_files.shift) do
  its(:content) { should match /include:.*services.d/ }
end

describe file(yaml_files.shift) do
  its(:content) { should match /plugin:.*memcached/ }
  its(:content) { should match /hostname:.*localhost/ }
  its(:content) { should match /port:.*6379/ }
end

describe file(yaml_files.shift) do
  its(:content) { should match /plugin:.*log-parser/ }
  its(:content) { should match /name:.*oom_killer/ }
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

describe command('cat /proc/$(cat /var/run/bipbip.pid)/oom_score_adj') do
  it { should return_exit_status 0 }
  its(:stdout) { should match '-1000' }
end
