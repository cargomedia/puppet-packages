require 'spec_helper'

describe 'unity' do

  describe package('unity') do
    it { should be_installed }
  end

  describe file('/usr/share/xsessions/ubuntu.desktop') do
    its(:content) { should match('Exec=gnome-session') }
  end

  describe command('gnome-session --version') do
    its(:exit_status) { should eq 0 }
  end

end
