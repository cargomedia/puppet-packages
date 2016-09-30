require 'spec_helper'

describe 'pulsar_rest_api' do

  describe user('pulsar-rest-api') do
    it { should have_home_directory '/home/pulsar-rest-api' }
  end

  describe package('pulsar-rest-api') do
    it { should be_installed.by('npm') }
  end

  describe file('/etc/pulsar-rest-api/config.yml') do
    its(:content) { should include "repo: 'foo/bar'" }
    its(:content) { should include "branch: 'master'" }
    its(:content) { should include "githubOauthSecret: 'secret'" }
    its(:content) { should include 'read: ["read-org", "read-user"]' }
    its(:content) { should include 'write: ["write-org"]' }
  end

  describe port(8080) do
    it { should be_listening }
  end

  describe command('curl -I localhost:8080') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match 'location: https://github.com/login/oauth/authorize' }
  end

  describe service('pulsar-rest-api') do
    it { should be_enabled }
    it { should be_running }
  end
end
