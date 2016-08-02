require 'spec_helper'

describe 'xorg::config' do

  describe file('/etc/X11/xorg.conf') do
    its(:content) { should match /Section "Files"/ }
    its(:content) { should match /ModulePath \/tmp\/0/ }
    its(:content) { should match /ModulePath \/tmp\/1/ }
    its(:content) { should match /Section "Device"/ }
    its(:content) { should match /Driver "dummy"/ }
  end

  describe file('/etc/X11/xorg.conf.d/xorg-multitouch.conf') do
    its(:content) { should match /Section "InputClass"/ }
    its(:content) { should match /MatchIsTouchpad 0/ }
    its(:content) { should match /Driver "hid-multitouch"/ }
  end

end
