require 'spec_helper'

describe file('/etc/hosts') do
  it { should be_file }
  its(:content) { should match('127.0.0.1	foo	localhost') }
end

describe file('/etc/hostname') do
  its(:content) { should match('foo') }
end

describe file('/etc/mailname') do
  its(:content) { should match('foo') }
end

describe host('foo') do
  it { should be_resolvable.by('hosts') }
end

describe command('hostname -f') do
  its(:stdout) { should match('foo') }
end
