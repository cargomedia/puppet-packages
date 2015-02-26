require 'spec_helper'

describe 'puppet::master puppetfile' do

  describe file('/etc/puppet/modules/mysql/metadata.json') do
    its(:content) { should match /name": "puppetlabs-mysql"/ }
  end

  describe file('/foobar') do
    it { should be_directory }
  end

  describe file('/usr/local/bin/sync_hiera.sh') do
    it { should be_executable }
    its(:content) { should match /foobar+.*\/etc\/puppet\/data\/+.*/ }
  end

  describe command('cd /etc/puppet/ && librarian-puppet config') do
    its(:stdout) { should match /rsync: true/ }
  end

  describe cron do
    it { should have_entry '* * * * * cd /etc/puppet && librarian-puppet update && /usr/local/bin/sync_hiera.sh' }
  end
end
