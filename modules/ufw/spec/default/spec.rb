require 'spec_helper'

describe 'ufw::default' do

  describe package('ufw') do
    it { should be_installed }
  end

  describe file('/var/log/ufw/ufw.log.1') do
    it { should be_file }
    its(:content) { should match /foo to bar/}
  end

  describe file ('/var/log/syslog.1') do
    its(:content) { should_not match /foo to bar/}
  end

  describe file ('/var/log/ufw/ufw.log') do
    it { should be_file }
  end

  describe iptables do
    it { should have_rule('-s 10.0.0.0/8').with_table('filter').with_chain('ufw-before-input') }
    it { should have_rule('-s 172.16.0.0/12').with_table('filter').with_chain('ufw-before-input') }
    it { should have_rule('-s 192.168.0.0/16').with_table('filter').with_chain('ufw-before-input') }
  end

end
