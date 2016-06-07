require 'spec_helper'

describe 'daemon:ordering' do

  # To really test the expected order of execution of these services
  # foo-before -> my-program -> foo-after
  # A reboot is needed
  describe service('my-program') do
    it { should be_enabled }
    it { should be_running }
  end

  describe file('/tmp/TS_after') do
    it { should be_file }
  end
end
