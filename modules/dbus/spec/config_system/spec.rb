require 'spec_helper'

describe 'dbus::config::system' do

  describe file('/etc/dbus-1/system.d/pulseaudio-system.conf') do
    its(:content) { should match /<policy user="user-name">/ }
    its(:content) { should match /<allow send_interface="org.bluez.Manager"\/>/ }
  end

end
