require 'spec_helper'

describe 'network' do

  describe file('/etc/hosts') do
    it { should be_file }
    its(:content) { should match('foo') }
  end

  describe host('foo') do
    it { should be_resolvable }
  end

  describe command('ip route show') do
    its(:stdout) { should match /127\.0\.44\.0\/26 via 127\.0\.0\.1/ }
  end
end
