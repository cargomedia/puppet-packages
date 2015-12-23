require 'spec_helper'

describe 'accountsservice::user' do

  describe package('accountsservice') do
    it { should be_installed }
  end

  describe command('dbus-send --system --type=method_call --print-reply --dest=org.freedesktop.Accounts /org/freedesktop/Accounts/User1234 org.freedesktop.DBus.Properties.Get string:"org.freedesktop.Accounts.User" string:"XSession"') do
    its(:stdout) { should match 'string "my-session"' }
  end

end
