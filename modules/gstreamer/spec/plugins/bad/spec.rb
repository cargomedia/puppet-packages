require 'spec_helper'

describe 'gstreamer::plugins::bad' do

  describe package('gstreamer1.0-plugins-base') do
    it { should be_installed }
  end

  describe package('gstreamer1.0-plugins-bad') do
    it { should be_installed }
  end

  describe command('ldd /usr/lib/x86_64-linux-gnu/gstreamer-1.0/libgstgaudieffects.so') do
    its(:stdout) { should match /liborc/ }
  end

  describe command('gst-inspect-1.0') do
    its(:stdout) { should match /geometrictransform:/ }
    its(:stdout) { should match /faad:/ }
    its(:stdout) { should match /audiovisualizers:/ }
    its(:stdout) { should match /smooth:/ }
    its(:stdout) { should match /gaudieffects:/ }
    its(:stdout) { should match /mpegtsdemux:/ }
    its(:stdout) { should match /ogg:/ }
    its(:stdout) { should match /opengl:/ }
    its(:stdout) { should match /decklink:/ }
    its(:stdout) { should match /bayer:/ }
  end

end
