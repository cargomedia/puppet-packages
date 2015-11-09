require 'spec_helper'

describe 'janus' do

  describe user('janus') do
    it { should exist }
  end

  describe file('/etc/monit/conf.d/janus') do
    it {should be_file}
  end

  describe service('janus') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(8989) do
    it { should be_listening }
  end

  describe command('wscat -n --connect ws://localhost:8989') do
    its(:exit_status) { should eq 255 }
  end
end
