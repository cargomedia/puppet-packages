require 'spec_helper'

describe file('/etc/hosts') do
  it { should be_file }
  it { should contain '127.0.0.1	foo.bar	foo localhost' }
end

describe file('/etc/hostname') do
  its(:content) { should match('foo') }
end

describe file('/etc/mailname') do
  its(:content) { should match('foo.bar') }
end

describe host('foo.bar') do
  it { should be_resolvable.by('hosts') }
end

describe host('foo') do
  it { should be_resolvable.by('hosts') }
end

describe command('hostname') do
  its(:stdout) { should match('foo') }
end

describe command('hostname -f') do
  its(:stdout) { should match('foo.bar') }
end
