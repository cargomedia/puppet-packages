require 'spec_helper'

describe 'daemon' do

  describe service('my-program') do
    it { should_not be_enabled }
    it { should_not be_running }
  end

  describe process('my-program') do
    it { should_not be_running }
  end

  describe file('/docker-run-my-program') do
    it { should be_file }
    it { should be_executable }
    its(:content) { should match('sudo -u alice /tmp/my-program --foo=12') }
  end

end
