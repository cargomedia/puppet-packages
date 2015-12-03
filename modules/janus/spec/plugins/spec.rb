require 'spec_helper'

describe 'janus::plugins' do

  describe file('/etc/janus/janus.plugin.cm.audioroom.cfg') do
    it { should be_file }
  end

  describe file('/opt/janus/lib/janus/plugins/libjanus_audioroom.so') do
    it { should be_file }
  end

  describe file('/etc/janus/janus.plugin.cm.rtpbroadcast.cfg') do
    it { should be_file }
  end

  describe file('/opt/janus/lib/janus/plugins/libjanus_rtpbroadcast.so') do
    it { should be_file }
  end

end
