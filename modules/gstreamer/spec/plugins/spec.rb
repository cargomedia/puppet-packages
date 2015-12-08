require 'spec_helper'

describe 'gstreamer::plugins' do

  ['gstreamer1.0-plugins-base', 'gstreamer1.0-plugins-libav',
   'gstreamer1.0-plugins-good', 'gstreamer1.0-plugins-bad',
   'gstreamer1.0-plugins-ugly',].each do |pkg|

    describe package(pkg) do
      it { should_be installed }
    end
  end

  describe command('gst-inspect-1.0') do
    its(:stdout) { should match /libav:/ }
    its(:stdout) { should match /debugutilsbad:/ }
    its(:stdout) { should match /effectv:/ }
    its(:stdout) { should match /gaudieffects:/ }
    its(:stdout) { should match /equalizer:/ }
  end


end
