require 'spec_helper'

describe command('WD="/etc/puppet/repos/puppet-packages"; test $(git --git-dir=${WD}/.git --work-tree=${WD} rev-list origin/master -1) = $(git --git-dir=${WD}/.git --work-tree=${WD} rev-list HEAD -1)') do
  it { should return_exit_status 0 }
end

describe cron do
  it { should have_entry '* * * * * cd /etc/puppet/repos/puppet-packages && git fetch --quiet origin && git fetch --quiet --tags origin && git checkout --quiet $(git rev-list origin/master -1 2>/dev/null || git rev-list master -1)' }
end

describe command('puppet apply --configprint modulepath') do
  its(:stdout) { should match '/etc/puppet/repos/puppet-packages' }
end
