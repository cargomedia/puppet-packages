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

  describe file('/etc/bipbip/services.d') do
    it { should be_directory }
  end

  yaml_files = ['/etc/bipbip/config.yml', '/etc/bipbip/services.d/memcache.yml']

  yaml_files.each do |file|
    describe command("ruby -e \"require 'psych';Psych.load_file('#{file}')\"") do
      its(:exit_status) { should eq 0 }
    end
  end

  describe file(yaml_files.shift) do
    its(:content) { should match /include:.*services.d/ }
    its(:content) { should match /tags:\n  - foo\n  - bar\n/ }
  end

  describe file(yaml_files.shift) do
    its(:content) { should match /plugin:.*memcached/ }
    its(:content) { should match /hostname:.*localhost/ }
    its(:content) { should match /port:.*6379/ }
  end

  describe command('logrotate -d /etc/logrotate.d/bipbip') do
    its(:exit_status) { should eq 0 }
  end

  describe command('cat /proc/$(pgrep -f "^/usr/bin/ruby([0-9.]*) /usr/local/bin/bipbip")/oom_score_adj') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match '-1000' }
  end
end
