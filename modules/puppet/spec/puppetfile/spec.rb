require 'spec_helper'

describe 'puppet::puppetfile' do

  describe file('/tmp/foo/modules/mysql/metadata.json') do
    its(:content) { should match /name": "puppetlabs-mysql"/ }
  end

  describe command('cd /tmp/foo && librarian-puppet config') do
    its(:stdout) { should match /rsync: true/ }
  end

  describe cron do
    it { should have_entry "* * * * * cd '/tmp/foo' && librarian-puppet update" }
  end
end
