require 'spec_helper'

describe 'fluentd:source-journald' do

  describe service('fluentd') do
    it { should be_running }
  end

  describe file('/var/lib/fluentd/journald_pos') do
    it { should be_directory }
  end

  describe file('/etc/fluentd/config.d/10-source-journald.conf') do
    its(:content) { should match /read_from_head true/ }
  end

  describe command('grep -hE "message...bar.*hostname" /tmp/dump/*.log') do
    its(:exit_status) { should eq 0 }
    its(:stdout) do
      is_expected.to include_json(
                       level: 'warning',
                       message: 'bar',
                       hostname: /.+/
                     )
    end
  end

  describe command('grep -hE "hostname.*message...foo" /tmp/dump/*.log"') do
    its(:exit_status) { should eq 0 }
    its(:stdout) do
      is_expected.to include_json(
                       level: 'error',
                       message: 'foo',
                       journal: {
                         transport: 'syslog',
                         unit: /.+/,
                         uid: /\d+/,
                         pid: /\d+/,
                       })
    end
  end
end
