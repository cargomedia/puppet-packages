require 'spec_helper'

eth1_matches = [
  'iface eth1 inet static',
  'address 10.10.20.122',
  'netmask 255.255.255.0',
  'up route add -net 10.10.134.0 netmask 255.255.255.128 gw 10.10.20.128; route add -net 10.10.138.0 netmask 255.255.255.192 gw 10.10.20.138'
]

describe 'network' do

  describe file('/etc/network/interfaces') do
    it { should be_file }
    eth1_matches.each do |match|
      it { should contain(match).from(/^iface eth1/).to(/^iface/) }
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

  describe command('netstat -rn') do
    its(:stdout) { should match /10.10.134.0.*10.10.20.128.*255.255.255.128.*eth1/ }
    its(:stdout) { should match /10.10.138.0.*10.10.20.138.*255.255.255.192.*eth1/ }
  end
end
