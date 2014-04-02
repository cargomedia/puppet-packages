require 'spec_helper'

describe package('puppetmaster') do
  it { should be_installed }
end

describe package('deep_merge') do
  it { should be_installed.by('gem') }
end

describe package('hiera-file') do
  it { should be_installed.by('gem').with_version('1.1.0') }
end

describe port(8140) do
  it { should be_listening }
end

describe file('/etc/puppet/manifests/site.pp') do
  its(:content) { should match /'puppet::agent': tag => 'bootstrap'/ }
end
