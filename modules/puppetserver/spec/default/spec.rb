require 'spec_helper'

describe 'puppetserver' do

  describe package('puppetserver') do
    it { should be_installed }
  end

  describe package('deep_merge') do
    it { should be_installed.by('gem') }
  end

  describe package('hiera-file') do
    it { should be_installed.by('gem').with_version('1.1.0') }
  end

  describe port(1234) do
    it { should be_listening }
  end

  describe command('/opt/puppetlabs/bin/puppet master --configprint environmentpath') do
    its(:stdout) { should match('/etc/puppetlabs/code/environments') }
  end

  describe file('/etc/puppetlabs/code/environments/production/manifests/site.pp') do
    its(:content) { should include 'include hiera_array(\'classes\', [])' }
  end
end
