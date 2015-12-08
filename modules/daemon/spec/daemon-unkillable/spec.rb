require 'spec_helper'

describe 'daemon' do

  describe service('my-program') do
    it { should be_enabled }
    it { should be_running }
  end

  describe process('my-program') do
    it { should be_running }
  end

  describe file('/tmp/spec-log') do
    it { should be_file }
    its(:content) { should eq("stop failed\n") }
  end

end
