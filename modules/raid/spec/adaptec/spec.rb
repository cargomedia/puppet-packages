require 'spec_helper'

describe file('/usr/local/bin/arcconf') do
  it { should be_executable }
end

describe file('/usr/sbin/check-adaptec-raid-health.sh') do
  it { should be_executable }
end

describe cron do
  it { should have_entry('*/5 * * * * /usr/sbin/check-adaptec-raid-health.sh').with_user('root') }
end
