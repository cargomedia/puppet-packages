require 'spec_helper'

describe service('mms-monitoring') do
  it { should be_enabled }
  it { should be_running }
  it { should be_monitored_by('monit') }
end

describe file ('/etc/mongodb-mms/monitoring-agent.config') do
  its(:content) { should match /mmsApiKey=test-key/ }
  its(:content) { should match /globalAuthUsername=mms/ }
  its(:content) { should match /globalAuthPassword=mms/ }
end
