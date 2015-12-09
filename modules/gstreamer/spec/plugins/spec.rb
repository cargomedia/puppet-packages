require 'spec_helper'

describe 'gstreamer::plugins' do

    describe package('gstreamer1.0-plugins-base') do
      it { should_be installed }
    end

    describe package('gstreamer1.0-libav') do
      it { should be_installed }
    end

    describe package('gstreamer1.0-plugins-good') do
      it { should be_installed }
    end

    describe package('gstreamer1.0-plugins-bad') do
      it { should be_installed }
    end

    describe package('gstreamer1.0-plugins-ugly') do
      it { should be_installed }
    end

    describe package('liborc-0.4-0') do
      it { should be_installed }
    end
  #
  # describe command('gst-inspect-1.0') do
  #   its(:stdout) { should match /libav:/ }
  #   its(:stdout) { should match /debugutilsbad:/ }
  #   its(:stdout) { should match /effectv:/ }
  #   its(:stdout) { should match /gaudieffects:/ }
  #   its(:stdout) { should match /equalizer:/ }
  # end


end
