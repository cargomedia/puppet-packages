require 'spec_helper'

describe 'gstreamer::plugins::bad' do

  describe package('gstreamer1.0-plugins-base') do
    it { should be_installed }
  end

  describe command('ldd /usr/lib/x86_64-linux-gnu/gstreamer-1.0/libgstvideoconvert.so') do
    its(:stdout) { should match /liborc/ }
  end

  describe command('ldd /usr/lib/x86_64-linux-gnu/gstreamer-1.0/libgstvideoscale.so') do
    its(:stdout) { should match /liborc/ }
  end

  describe command('gst-inspect-1.0') do
    its(:stdout) { should match /audioconvert:/ }
    its(:stdout) { should match /videoconvert:/ }
    its(:stdout) { should match /subparse:/ }
    its(:stdout) { should match /gio:/ }
    its(:stdout) { should match /audiorate:/ }
    its(:stdout) { should match /ogg:/ }
    its(:stdout) { should match /vorbis:/ }
    its(:stdout) { should match /cdparanoia:/ }
    its(:stdout) { should match /videoscale:/ }
  end

end
