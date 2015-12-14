require 'spec_helper'

describe 'gstreamer::plugins::libav' do

  describe package('gstreamer1.0-libav') do
    it { should be_installed }
  end

  describe package('gstreamer1.0-plugins-base') do
    it { should be_installed }
  end

  describe command('ldd /usr/lib/x86_64-linux-gnu/gstreamer-1.0/libgstlibav.so') do
    its(:stdout) { should match /liborc/ }
  end

  describe command('gst-inspect-1.0') do
    its(:stdout) { should match /libav:/ }
  end

end
