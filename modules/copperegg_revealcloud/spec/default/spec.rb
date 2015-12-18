require 'spec_helper'

describe 'copperegg_revealcloud' do

  describe command('2>&1 /usr/local/revealcloud/revealcloud -V') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match 'RevealCloud' }
  end

  describe service('revealcloud') do
    it { should be_running }
    it { should be_enabled }
  end

  describe file('/etc/init.d/revealcloud') do
    it { should be_file }
  end

  describe file('/etc/init.d/revealcloud') do
    it { should be_file }
    its(:content) { should match '-t tag1' }
    its(:content) { should match '-t tag2' }
  end
end
