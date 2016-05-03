require 'spec_helper'

describe 'nvidia' do

  describe package('nvidia-346') do
    it { should be_installed }
  end

  describe file('/etc/X11/xorg.conf') do
    it { should be_file }
    its(:content) { should match /nvidia-xconfig/ }
  end

end
