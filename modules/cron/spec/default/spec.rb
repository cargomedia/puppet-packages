require 'spec_helper'

describe 'cron' do

  describe package('cron') do
    it { should be_installed }
  end

  describe service('cron') do
    it { should be_enabled }
    it { should be_running }
  end

  describe command('ls /var/run/crond.pid') {
    its(:exit_status) { should_not eq 0 }
  }
end
