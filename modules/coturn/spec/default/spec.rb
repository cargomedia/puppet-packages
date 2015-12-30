require 'spec_helper'

describe 'coturn' do

  describe package('coturn') do
    it { should be_installed }
  end

  describe service('coturn') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(5766) do
    it { should be_listening }
  end

  describe file('/etc/turnserver.conf') do
    its(:content) { should match /^mobility/ }
    its(:content) { should match /^user=admin:admin/ }
    its(:content) { should match /^user=super:super/ }
    its(:content) { should match /^realm=mydomain.com$/ }
  end

end
