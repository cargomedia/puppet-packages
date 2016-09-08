require 'spec_helper'

eth1_matches = [
  'iface eth1 inet static',
  'address 10.10.20.122',
  'netmask 255.255.255.0',
  'slaves eth2 eth3',
  'mtu 9000',
  'bond-mode 4',
  'bond-miimon 100',
  'bond-downdelay 0',
  'bond-updelay 0',
  'bond-lacp-rate fast',
  'bond-xmit_hash_policy 1',
  'up route add -net 10.10.130.0 netmask 255.255.255.0 gw 10.10.20.128'
]

eth3_matches = [
  'iface eth3 inet manual',
  'address 10.10.40.10',
]

describe 'network' do

  describe file('/etc/network/interfaces') do
    it { should be_file }
    eth1_matches.each do |match|
      it { should contain(match).from(/^iface eth1/).to(/^iface/) }
    end
    eth3_matches.each do |match|
      it { should contain(match).after(/^iface eth3/) }
    end
  end

  describe file('/etc/hosts') do
    it { should be_file }
    its(:content) { should match('foo') }
  end

  describe host('foo') do
    it { should be_resolvable }
  end

  describe interface('eth1') do
    it { should have_ipv4_address("10.10.20.122") }
  end

  describe interface('eth3') do
    it { should_not have_ipv4_address("10.10.40.10") }
  end

  describe command('netstat -rn') do
    its(:stdout) { should match /10.10.130.0.*eth1/ }
  end
end
