require 'spec_helper'

describe 'xorg::server_utils' do

  describe package('x11-xserver-utils') do
    it { should be_installed }
  end

  describe command('xset -version') do
    its(:exit_status) { should eq 0 }
  end

end
