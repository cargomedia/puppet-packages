require 'spec_helper'

describe file('/etc/puppet/modules/mysql/Modulefile') do
  its(:content) { should match /name 'puppetlabs-mysql'/ }
end

describe file('/usr/local/bin/sync_hiera.sh') do
  it { should be_executable }
  its(:content) { should match /rsync -a --delete '\/etc\/puppet\/hiera\/data' '\/foobar\/'/ }
end

describe cron do
  it { should have_entry '* * * * * cd /etc/puppet && librarian-puppet update && /usr/local/bin/sync_hiera.sh' }
end
