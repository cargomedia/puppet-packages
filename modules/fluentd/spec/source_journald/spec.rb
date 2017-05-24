require 'spec_helper'

describe 'fluentd:source-journald' do

  describe service('fluentd') do
    it { should be_running }
  end

  describe file('/var/lib/fluentd/journald_pos_systemd') do
    it { should be_directory }
  end

  describe command('logger -p local0.error foo') do
    its(:exit_status) { should eq 0 }
  end

  # see http://docs.fluentd.org/v0.14/articles/signals#sigusr1
  describe command('sudo pkill -SIGUSR1 fluentd') do
    its(:exit_status) { should eq 0 }
  end

  describe command('timeout --signal=9 3 bash -c "while ! (grep -e message...foo /tmp/dump/*.log | grep -v grep); do sleep 0.5; done"') do
    its(:exit_status) { should eq 0 }
    its(:stdout) do
      is_expected.to include_json(
                       level: 'error',
                       message: 'foo',
                       journal: {
                         transport: 'syslog',
                         unit: 'ssh.service',
                         uid: '0',
                       })
    end
  end
end
