require 'spec_helper'

describe 'copperegg_revealcloud' do

  describe command('2>&1 /usr/local/revealcloud/revealcloud -V') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /v3\.3-92-g0814c8d/ }
  end

  describe service('revealcloud') do
    it { should be_running }
    it { should be_enabled }
  end

  describe file('/etc/init.d/revealcloud') do
    it { should be_file }
  end

  describe file('/etc/monit/conf.d/revealcloud') do
    it { should be_file }
  end

  describe command('cat /proc/$(cat /usr/local/revealcloud/run/revealcloud.pid)/oom_score_adj') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match '-1000' }
  end

  describe file('/etc/init.d/revealcloud') do
    it { should be_file }
    its(:content) { should match '-t tag1' }
    its(:content) { should match '-t tag2' }
  end
end
