require 'spec_helper'

describe 'network::nat' do

  describe package('iptables') do
    it { should be_installed }
  end

  describe file('/proc/sys/net/ipv4/ip_forward') do
    its(:content) { should match /1/ }
  end

  describe iptables do
    it { should have_rule('-o eth0 -j SNAT --to-source 10.73.8.2').with_table('nat').with_chain('POSTROUTING') }
  end

  describe iptables do
    it { should have_rule('-i eth0 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT').with_table('filter').with_chain('FORWARD') }
  end

  describe iptables do
    it { should have_rule('-i eth1 -o eth0 -j ACCEPT').with_table('filter').with_chain('FORWARD') }
  end
end
