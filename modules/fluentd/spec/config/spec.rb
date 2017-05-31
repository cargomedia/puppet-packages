require 'spec_helper'

describe 'fluentd::config' do

  describe service('fluentd') do
    it { should be_running }
  end

  describe command('journalctl -u fluentd --no-pager') do
    its(:stdout) { should match('<match \*\*>') }
    its(:stdout) { should match('<match \*\*>') }
    its(:stdout) { should match('<match \*\*>') }
  end

  describe command('grep -he BAR /tmp/my-match-1/*') do
    its(:exit_status) { should eq 0 }
    its(:stdout) do
      is_expected.to include_json(
                       level: 'warning',
                       message: 'BAR',
                       hostname: /.+/,
                     )
    end
  end

  describe command('grep -he FOO /tmp/my-match-2/*') do
    its(:exit_status) { should eq 0 }
    its(:stdout) do
      is_expected.to include_json(message: 'FOO')
    end
  end
end
