require 'spec_helper'

describe 'monit' do

  describe command('cat /proc/$(cat /var/run/monit.pid)/oom_score_adj') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match '-1000' }
  end

  describe process('monit') do
    it { should be_running }
  end

  describe file('/etc/monit/monitrc') do
    it 'is a file' do
      expect(subject).to be_file
    end
    it "default from address is root@$::trusted['domain']"  do
      expect(subject).to contain('root@vagrantup.com').after(/from:/)
    end
  end
end
