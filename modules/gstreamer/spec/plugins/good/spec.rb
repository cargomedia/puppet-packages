require 'spec_helper'

describe 'gstreamer::plugins::good' do

  describe package('gstreamer1.0-plugins-good') do
    it { should be_installed }
  end

  describe package('gstreamer1.0-plugins-base') do
    it { should be_installed }
  end

  describe command('ldd /usr/lib/x86_64-linux-gnu/gstreamer-1.0/libgstmatroska.so') do
    its(:stdout) { should match /liborc/ }
  end

  describe command('gst-inspect-1.0') do
    its(:stdout) { should match /matroska:/ }
    its(:stdout) { should match /monoscope:/ }
    its(:stdout) { should match /multifile:/ }
    its(:stdout) { should match /multipart:/ }
    its(:stdout) { should match /replaygain:/ }
    its(:stdout) { should match /shapewipe:/ }
    its(:stdout) { should match /spectrum:/ }
    its(:stdout) { should match /videobox:/ }
  end

end
