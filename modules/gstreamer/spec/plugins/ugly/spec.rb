require 'spec_helper'

describe 'gstreamer::plugins::ugly' do

  describe package('gstreamer1.0-plugins-ugly') do
    it { should be_installed }
  end

  describe command('ldd /usr/lib/x86_64-linux-gnu/gstreamer-1.0/libgstmpeg2dec.so') do
    its(:stdout) { should match /liborc/ }
  end

  describe command('gst-inspect-1.0') do
    its(:stdout) { should match /dvdsub:/ }
    its(:stdout) { should match /realmedia:/ }
    its(:stdout) { should match /xingmux:/ }
    its(:stdout) { should match /a52dec:/ }
    its(:stdout) { should match /amrnb:/ }
    its(:stdout) { should match /amrwbdec:/ }
    its(:stdout) { should match /cdio:/ }
    its(:stdout) { should match /dvdreadsrc:/ }
    its(:stdout) { should match /lame:/ }
    its(:stdout) { should match /mad:/ }
    its(:stdout) { should match /mpeg2dec:/ }
  end

end
