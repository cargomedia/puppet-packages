require 'spec_helper'

describe 'fluentd::config' do

  describe service('fluentd') do
    it { should be_running }
  end

  describe file('/var/log/fluentd/fluentd.log') do
    its(:content){ should match('<match \*\*>') }
    its(:content){ should match('<match \*\*>') }
    its(:content){ should match('<match \*\*>') }
  end

end
