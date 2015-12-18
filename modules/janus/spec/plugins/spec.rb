require 'spec_helper'

describe 'janus::plugins' do

  describe file('/etc/janus/janus.plugin.cm.audioroom.cfg') do
    it { should be_file }
  end

  describe file('/etc/janus/janus.plugin.cm.rtpbroadcast.cfg') do
    it { should be_file }
  end

  describe command('janus -C /etc/janus/janus.cfg -F /etc/janus') do
    its(:stdout) { should match /Loading plugin \'libjanus_audioroom\.so\'/ }
    its(:stdout) { should match /JANUS CM audio plugin initialized!/ }
    its(:stdout) { should match /Loading plugin \'libjanus_rtpbroadcast\.so\'/ }
    its(:stdout) { should match /JANUS CM video plugin initialized!/ }
  end
end
