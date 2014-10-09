require 'spec_helper'

eth1_matches = [
    'iface eth1 inet static',
    'address 10.10.20.10',
    'netmask 255.255.0.0',
    'gateway 10.10.10.1',
    'slaves eth2 eth3',
    'mtu 9000',
    'bond-mode 4',
    'bond-miimon 100',
    'bond-downdelay 0',
    'bond-updelay 0',
    'bond-lacp-rate fast',
    'bond-xmit_hash_policy 1',
    'up route add -net 10.0.0.0/8 gw 10.55.40.129'
]

eth3_matches = [
    'iface eth3 inet manual',
    'address 10.10.40.10',
    'netmask 255.255.255.0',
    'gateway 10.10.40.1',
    'mtu 16000',
]


describe file('/etc/network/interfaces') do
  it { should be_file }
  eth1_matches.each do |match|
    it { should contain(match).from(/^iface eth1/).to(/^iface/) }
  end
  its(:content) { should match('iface eth2 inet dhcp') }
  its(:content) { should_not match('auto eth3') }
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

describe file('/etc/resolv.conf') do
  it { should be_file }
  its(:content) { should match('example.local') }
end
