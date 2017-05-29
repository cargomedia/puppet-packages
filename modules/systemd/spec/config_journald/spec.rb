require 'spec_helper'

describe 'systemd::journald_config' do

  describe file('/etc/systemd/journald.conf') do
    it { should be_file }
    its(:content) { should match /Storage=persistent/ }
    its(:content) { should match /RateLimitBurst=30/ }
    its(:content) { should match /RateLimitInterval=5s/ }
    its(:content) { should match /MaxRetentionSec=10month/ }
  end

  describe file('/tmp/journal_dump') do
    its(:content) { should match /Suppressed+.+messages+.+from/ }
  end

  describe file('/var/log/journal') do
    it { should be_directory }
    it { should be_grouped_into 'systemd-journal' }
    it { should be_mode '2750' }
  end

  describe file('/var/log/journal/boo') do
    it { should be_directory }
    it { should be_grouped_into 'systemd-journal' }
    it { should be_mode '2750' }
  end

end
