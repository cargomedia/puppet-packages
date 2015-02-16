require 'spec_helper'

describe 'ulimit' do

  describe file('/etc/security/limits.conf') do
    its(:content) { should match 'root - nofile 65536' }
  end

  describe file('/etc/security/limits.d') do
    it { should be_directory }
  end
end
