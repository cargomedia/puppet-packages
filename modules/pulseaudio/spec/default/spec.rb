require 'spec_helper'

describe 'pulseaudio' do

  describe package('pulseaudio') do
    it { should be_installed }
  end

  describe file('/etc/pulse/client.conf') do
    it { should be_file }
    it { should exist }
    its(:content) { should match /autospawn=no/ }
  end

end
