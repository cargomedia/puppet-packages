require 'spec_helper'

describe 'dbus::service' do

  describe service('dbus') do
    it { should be_enabled }
    it { should be_running }
  end

end
