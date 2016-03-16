require 'spec_helper'

describe 'rsyslog::entry' do

  describe file('/var/log/foo.log') do
    it { should be_file }
    its(:content) { should match /\[FOO\] bar/ }
  end
end
