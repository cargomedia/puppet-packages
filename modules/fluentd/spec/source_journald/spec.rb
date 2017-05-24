require 'spec_helper'

describe 'fluentd:source-journald' do

  describe service('fluentd') do
    it { should be_running }
  end

  describe file('/var/lib/fluentd/journald_pos_systemd') do
    it { should be_directory }
  end

  describe command('grep foo /tmp/dump/*.log | tail -1') do
    its(:exit_status) { should eq 0 }
    its(:stdout) do
      is_expected.to include_json(
                       message: 'foo',
                       journal: {
                         transport: 'syslog',
                         unit: 'ssh.service',
                         uid: '0',
                       })
    end
  end
end
