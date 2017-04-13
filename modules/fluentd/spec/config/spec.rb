require 'spec_helper'

describe 'fluentd::config' do

  describe service('fluentd') do
    it { should be_running }
  end

  describe command('journalctl -u fluentd --no-pager') do
    its(:stdout){ should match('<match \*\*>') }
    its(:stdout){ should match('<match \*\*>') }
    its(:stdout){ should match('<match \*\*>') }
  end

end
