require 'spec_helper'

describe service('mms-backup') do
  it { should be_enabled }
  it { should be_running }
  it { should be_monitored_by('monit') }
end

describe file ('/etc/mongodb-mms/backup-agent.config') do
  its(:content) { should match /mmsApiKey=test-key/ }
end
