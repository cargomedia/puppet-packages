require 'spec_helper'

describe 'cm_janus' do

  describe file('/etc/cm-janus/config.yaml') do
    its(:content) { should match /serverKey: 'bar'/ }
    its(:content) { should match /port: 8800/ }
    its(:content) { should match /baseUrl: 'http:\/\/www\.example\.com'/ }
  end

  describe file('/etc/monit/conf.d/cm-janus') do
    it { should be_file }
  end

  describe file('/var/log/cm-janus/cm-janus.log') do
    it { should be_file }
  end

  describe service('cm-janus') do
    it { should be_enabled }
    it { should be_running }
  end

end
