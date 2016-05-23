require 'spec_helper'

describe 'dyndns_updater:default' do

  describe file('/etc/dyndns_updater/script_zone.example.com') do
    it { should be_file }
    its(:content) { should match /server dyndns\.example\.com/ }
    its(:content) { should match /zone zone\.example\.com/ }
    its(:content) { should match /key alice secret/ }
  end

  describe package('dnsutils') do
    it { should be_installed }
  end

  describe command('facter external_ip') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /\d{1,3}\.\d{1,3}\.\d{1,3}/}
  end

  describe cron do
    it { should have_entry "*/10 * * * * 2>&1 /usr/bin/nsupdate /etc/dyndns_updater/script >/dev/null || echo 'An error occured updating Dyndns'" }
  end

end
