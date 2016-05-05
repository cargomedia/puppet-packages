require 'spec_helper'

describe 'xorg::config::multitouch' do

  describe package('xserver-xorg-input-multitouch') do
    it { should be_installed }
  end

  describe file('/etc/X11/xorg.conf.d/50-multitouch.conf') do
    its(:content) { should match /Driver "hid-multitouch"/ }
    its(:content) { should match /MatchIsTouchpad "true"/ }
  end

end
