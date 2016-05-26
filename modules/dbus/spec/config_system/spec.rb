require 'spec_helper'

describe 'dbus::config::system' do

  describe service('dbus') do
    it { should be_enabled }
    it { should be_running }
  end

end
