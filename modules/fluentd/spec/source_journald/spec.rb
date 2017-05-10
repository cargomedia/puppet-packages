require 'spec_helper'

describe 'fluentd:source-journald' do

  describe service('fluentd') do
    it { should be_running }
  end

  describe file('/var/lib/fluentd/journald_pos') do
    it { should be_directory }
  end

  describe file('/tmp/dump') do
    it { should be_directory }
  end

  describe command('journalctl -u fluentd |grep "fluentd worker is now running"') do
    its(:exit_status) { should eq 0 }
  end

  describe command('grep "fluentd worker is now running" /tmp/dump/*') do
    its(:exit_status) { should eq 0 }
  end

end
