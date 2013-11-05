require 'spec_helper'

describe file('/etc/puppet/repos/puppet-packages/.git/HEAD') do
  it { should contain '6297f205d6e410c0d1b51d05af9f9f41394412be' }
end

describe command('test -f /etc/puppet/repos/puppet-packages/modules/puppet/manifests/git-modules.pp') do
  it { should return_exit_status 0 }
end

describe command('test -f /etc/puppet/repos/puppet-packages/modules/puppet/spec/git-modules/spec.rb') do
  it { should return_exit_status 1 }
end

describe cron do
  it { should have_entry '* * * * * cd /etc/puppet/repos/puppet-packages && git fetch --quiet origin && git fetch --quiet --tags origin && git checkout --quiet 6297f205d6e410c0d1b51d05af9f9f41394412be && git merge --quiet --ff-only origin 6297f205d6e410c0d1b51d05af9f9f41394412be' }
end

describe command('puppet apply --configprint modulepath') do
  its(:stdout) { should match '/etc/puppet/repos/puppet-packages' }
end
