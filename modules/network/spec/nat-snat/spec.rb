require 'spec_helper'

describe 'network::nat_snat' do

  describe command('curl --proxy "" --max-time 1 http://10.10.20.122:1337') do
    its(:exit_status) { should be_between(28, 52) }
  end

  describe file('/tmp/stderr_output') do
    its(:content) { should match /[C|c]onnect+.+from+.+192\.168\.20\.122/ }
  end

  describe package('iptables') do
    it { should be_installed }
  end

  describe file('/proc/sys/net/ipv4/ip_forward') do
    its(:content) { should match /1/ }
  end

  describe iptables do
    it { should have_rule('-o lo -j SNAT --to-source 192.168.20.122').with_table('nat').with_chain('POSTROUTING') }
  end

  describe iptables do
    it { should have_rule('-i lo -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT').with_table('filter').with_chain('puppet-nat') }
  end

  describe iptables do
    it { should have_rule('-i eth0 -o lo -j ACCEPT').with_table('filter').with_chain('puppet-nat') }
  end
end
