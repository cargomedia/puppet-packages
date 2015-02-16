require 'spec_helper'

describe 'bipbip' do

  describe user('bipbip') do
    it { should exist }
    it { should have_home_directory '/home/bipbip' }
  end

  describe command('/usr/local/bin/bipbip -v') do
    its(:exit_status) { should eq 0 }
  end

  describe service('bipbip') do
    it { should be_enabled }
    it { should be_running }
  end

  describe file('/etc/monit/conf.d/bipbip') do
    it { should be_file }
  end

  describe file('/etc/init.d/bipbip') do
    it { should be_executable }
  end

  describe file('/etc/bipbip/services.d') do
    it { should be_directory }
  end

  yaml_files = ['/etc/bipbip/config.yml', '/etc/bipbip/services.d/memcache.yml', '/etc/bipbip/services.d/logparser.yml']

  yaml_files.each do |file|
    describe command("ruby -e \"require 'psych';Psych.load_file('#{file}')\"") do
      its(:exit_status) { should eq 0 }
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

  describe file('/etc/logrotate.d/bipbip') do
    it { should be_file }
  end

  describe command('logrotate -d /etc/logrotate.d/bipbip') do
    its(:exit_status) { should eq 0 }
  end

  describe command('cat /proc/$(cat /var/run/bipbip.pid)/oom_score_adj') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match '-1000' }
  end
end
