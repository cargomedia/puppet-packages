require 'spec_helper'

describe file('/etc/network/interfaces') do
  it { should be_file }
  its(:content) { should match('eth1') }
  its(:content) { should match('eth2') }
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
