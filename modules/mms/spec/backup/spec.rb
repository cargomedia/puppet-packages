require 'spec_helper'

describe 'mms::backup' do

  describe service('mms-backup') do
    it { should be_enabled }
    it { should be_running }
  end

  describe file ('/etc/mongodb-mms/backup-agent.config') do
    its(:content) { should match /mmsApiKey=test-key/ }
  end
end
