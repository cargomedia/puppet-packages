require 'spec_helper'

describe 'copperegg_revealcloud' do

  describe command('2>&1 /usr/local/revealcloud/revealcloud -V') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /v3\.3-9-g06271da/ }
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
end
