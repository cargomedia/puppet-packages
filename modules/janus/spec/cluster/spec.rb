require 'spec_helper'

describe 'janus::cluster' do

  describe user('janus') do
    it { should exist }
  end

  describe command ('netstat -tnalp |grep -E "LISTEN+.+janus"') do
    its(:stdout) { should match /8000+.+LISTEN/ }
    its(:stdout) { should match /8001+.+LISTEN/ }
    its(:stdout) { should match /8002+.+LISTEN/ }
    its(:stdout) { should match /8003+.+LISTEN/ }
    its(:stdout) { should match /10000+.+LISTEN/ }
    its(:stdout) { should match /10001+.+LISTEN/ }
    its(:stdout) { should match /10003+.+LISTEN/ }
  end

  describe file('/opt/janus-cluster/edge1/var/log/janus/janus.log') do
    its(:content) { should match /Plugins folder: \/opt\/janus-cluster\/edge1\/usr\/lib\/janus\/plugins.enabled/ }
    its(:content) { should match /Loading plugin 'libjanus_audioroom\.so'/ }
    its(:content) { should match /JANUS CM audio plugin initialized!/ }
  end

  describe file('/opt/janus-cluster/edge2/var/log/janus/janus.log') do
    its(:content) { should match /Plugins folder: \/opt\/janus-cluster\/edge2\/usr\/lib\/janus\/plugins.enabled/ }
    its(:content) { should match /Loading plugin 'libjanus_audioroom\.so'/ }
    its(:content) { should match /JANUS CM audio plugin initialized!/ }
  end

  describe file('/opt/janus-cluster/edge3/var/log/janus/janus.log') do
    its(:content) { should match /Plugins folder: \/opt\/janus-cluster\/edge3\/usr\/lib\/janus\/plugins.enabled/ }
    its(:content) { should match /Loading plugin 'libjanus_rtpbroadcast\.so'/ }
    its(:content) { should match /JANUS CM video plugin: Initialized!/ }
  end
end
