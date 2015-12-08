require 'spec_helper'

describe 'systemd::unit' do

  describe file('/etc/systemd/system/my-daemon.service') do
    it { should be_file }
  end

  describe service('my-daemon') do
    it { should be_enabled }
    it { should be_running }
  end

  describe process('my-daemon') do
    it { should be_running }
  end

end
