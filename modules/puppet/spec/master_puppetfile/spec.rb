require 'spec_helper'

describe file('/etc/puppet/modules/mysql/Modulefile') do
  its(:content) { should match /name 'puppetlabs-mysql'/ }
end

describe cron do
  it { should have_entry '* * * * * cd /etc/puppet && librarian-puppet update' }
end
