require 'spec_helper'

describe 'cm_janus' do

  describe file('/etc/cm-janus/config.yaml') do
    its(:content) { should match /^httpServer:.*/ }
    its(:content) { should match /port: 8801/ }
    its(:content) { should match /apiKey: 'foobar23'.*/ }
    its(:content) { should match /^cmApi:.*/ }
    its(:content) { should match /baseUrl: 'http:\/\/www.cm.dev'/ }
    its(:content) { should match /convertCommand: 'ionice -c 2 -n 7 nice -n 19 lame <%= wavFile %> <%= mp3File %>'/ }
    its(:content) { should match /retryMaxDelay: 300000/ }
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

  describe port(8801) do
    it { should be_listening }
  end
end
