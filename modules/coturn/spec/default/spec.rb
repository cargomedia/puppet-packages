require 'spec_helper'

describe 'coturn' do

  describe package('coturn') do
    it { should be_installed }
  end

  describe service('coturn') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(5766) do
    it { should be_listening }
  end

  describe file('/etc/coturn/turnserver.conf') do
    its(:content) { should match /^mobility/ }
    its(:content) { should match /^user=admin:admin/ }
    its(:content) { should match /^user=super:0x892bd158de5ce05f7792112eca1be3ca/ }
    its(:content) { should match /^realm=mydomain.com$/ }
  end

  describe command('turnutils_uclient -u super -w supper-bad-pass -m 1 -n 1 -M -B -z 1 127.0.0.1') do
    its(:stdout) { should match /0: ERROR: Cannot complete Allocation/ }
  end

  describe command('timeout 2 turnutils_uclient -u super -w super -m 1 -n 1 -M -B -z 1 127.0.0.1') do
    its(:stdout) { should match /1: start_mclient: msz=2, tot_send_msgs=0, tot_recv_msgs=0, tot_send_bytes ~ 0, tot_recv_bytes ~ 0/ }
  end

  describe file('/var/log/coturn/turnserver.log') do
    its(:content) { should_not match /WARNING:/ }
    its(:content) { should_not match /ERROR:/ }
  end

end
