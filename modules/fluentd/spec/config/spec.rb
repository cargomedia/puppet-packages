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

  describe command('grep -r FOO /tmp/my-match-2/*') do
    its(:exit_status) { should eq 0 }
  end
end
