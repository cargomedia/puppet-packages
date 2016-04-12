require 'spec_helper'

describe 'puppetmaster' do

  describe package('puppetmaster') do
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

  describe file('/etc/puppet/manifests/site.pp') do
    its(:content) { should include 'include hiera_array(\'classes\', [])' }
  end
end
