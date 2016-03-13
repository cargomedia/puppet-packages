require 'spec_helper'

describe 'gearman::persistence::mysql' do

  describe command('cat /proc/$(pgrep gearman)/cmdline') do
    its(:stdout) { should match /-q+.*mysql/ }
    its(:stdout) { should_not match /-q+.*libsqlite3/ }
  end

  describe service('gearman-job-server') do
    it { should be_running }
  end

  describe port(4730) do
    it { should be_listening }
  end
end
