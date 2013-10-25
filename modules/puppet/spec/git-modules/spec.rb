require 'spec_helper'

describe file('/etc/puppet/repos/puppet-packages') do
  it { should be_directory }
end

describe ('test -f /etc/puppet/repos/puppet-packages/modules/puppet/manifests/git-modules.pp') do
  it { should return_exit_status 0 }
end

describe ('test -f /etc/puppet/repos/puppet-packages/modules/puppet/spec/git-modules/git-modules_spec.rb') do
  it { should return_exit_status 0 }
end
