require 'spec_helper'

describe 'fluentd::config' do

  describe service('fluentd') do
    it { should be_running }
  end

  describe command('fluentd -c /etc/fluentd/fluent.conf --dry-run') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match('<match \*\*>') }
    its(:stdout) { should match('<match match1.\*\*>') }
    its(:stdout) { should match('<filter filter1.\*\*>') }
  end

end
