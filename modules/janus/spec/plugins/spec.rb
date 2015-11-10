require 'spec_helper'

describe 'janus::plugins' do

  describe file('/etc/janus/janus.plugin.audioroom.cfg') do
    it { should be_file }
  end

  describe file('/etc/janus/janus.plugin.rtpbroadcast.cfg') do
    it { should be_file }
  end

end
