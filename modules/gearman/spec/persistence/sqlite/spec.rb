require 'spec_helper'

describe 'gearman persistence sqlite' do

  describe file('/var/log/gearman-job-server/gearman-persist.sqlite3') do
    it { should be_file }
    it { should be_owned_by 'gearman' }
  end

  describe command('cat /proc/$(pgrep gearman)/cmdline') do
    its(:stdout) { should_not match /-q mysql/ }
    its(:content) { should match /-q libsqlite3/ }
  end

  describe service('gearman-job-server') do
    it { should be_running }
  end

  describe port(4730) do
    it { should be_listening }
  end

  describe command('lsof | grep gearmand | grep -q gearman-persist.sqlite3') do
    its(:exit_status) { should eq 0 }
  end
end
