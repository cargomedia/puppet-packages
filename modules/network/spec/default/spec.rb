require 'spec_helper'

describe file('/etc/network/interfaces') do
  it { should be_file }
  it { should contain 'eth1' }
  it { should contain 'eth2' }
end

describe file('/etc/hosts') do
  it { should be_file }
  it { should contain 'foo' }
end

describe host('foo') do
  it { should be_resolvable }
end

describe file('/etc/resolv.conf') do
  it { should be_file }
  it { should contain 'example.local' }
end
