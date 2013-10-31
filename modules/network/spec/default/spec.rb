require 'spec_helper'

describe file('/etc/network/interfaces') do
  it { should be_file }
  it { should contain 'eth1' }
  it { should contain 'eth2' }
end

describe interface('eth1') do
  it { should have_ipv4_address("10.10.20.10") }
  it { should have_ipv4_address("10.10.20.10/16") }
end

describe file('/etc/hosts') do
  it { should be_file }
  it { should contain 'foo' }
end

describe host('foo') do
  it { should be_resolvable }
end

describe default_gateway do
  its(:ipaddress) { should eq '10.10.10.1' }
  its(:interface) { should eq 'eth1' }
end

describe file('/etc/resolv.conf') do
  it { should be_file }
  it { should contain 'foo' }
end
