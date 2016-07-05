require 'spec_helper'

describe 'janus::role::rtpbroadcast' do

  describe command ('netstat -tnalp |grep -E "LISTEN+.+janus"') do
    its(:stdout) { should match /8300+.+LISTEN/ }
    its(:stdout) { should match /9300+.+LISTEN/ }
    its(:stdout) { should match /10000+.+LISTEN/ }
    its(:stdout) { should match /10001+.+LISTEN/ }
  end

  describe file('/opt/janus-cluster/repeater1/var/log/janus/janus.log') do
    its(:content) { should_not match /Plugins folder: \/opt\/janus-cluster\/instance1\/usr\/lib\/janus\/plugins.enabled/ }
    its(:content) { should_not match /Loading plugin 'libjanus_audioroom\.so'/ }
    its(:content) { should_not match /JANUS CM audio plugin initialized!/ }
  end

  describe file('/opt/janus-cluster/repeater1-multiedge1/var/log/janus/janus.log') do
    its(:content) { should_not match /Plugins folder: \/opt\/janus-cluster\/instance2\/usr\/lib\/janus\/plugins.enabled/ }
    its(:content) { should_not match /Loading plugin 'libjanus_audioroom\.so'/ }
    its(:content) { should_not match /JANUS CM audio plugin initialized!/ }
  end

end
