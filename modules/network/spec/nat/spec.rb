require 'spec_helper'

describe 'network::nat' do

  describe file('/proc/sys/net/ipv4/ip_forward') do
    its(:content) { should match /1/ }
  end

  describe iptables do
    it { should have_rule('-o eth0 -j SNAT --to-source 192.168.20.122').with_table('nat').with_chain('POSTROUTING') }
    it { should have_rule('-i eth0 -o eth5 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT').with_table('filter').with_chain('ufw-before-input') }
  end
end
