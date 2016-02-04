require 'spec_helper'

describe 'systemd::unit' do

  describe file('/etc/systemd/system/my-daemon.service') do
    it { should be_file }
  end

  describe service('my-daemon') do
    it { should be_enabled }
    it { should be_running }
  end

  describe file('/etc/systemd/coredump.conf') do
    it { should be_file }
    its(:content) { should match /Compress=no/ }
    its(:content) { should match /MaxUse=10000/ }
  end

  describe command('ls /tmp/foo.my-daemon.*') do
    its(:exit_status) { should eq 0 }
  end
end
