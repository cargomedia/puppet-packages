require 'spec_helper'

describe 'xpra' do

  describe service('xpra-display-199') do
    it { should be_enabled }
    it { should be_running }
  end

  describe command('sudo xpra info :199') do
    its(:stdout) { should match /^env.DISPLAY=:199$/ }
    its(:stdout) { should match /^server.display=:199$/ }
  end

  describe command('DISPLAY=:199 xrefresh') do
    its(:exit_status) { should eq 0 }
  end

  describe command('sudo -u nobody DISPLAY=:199 xrefresh') do
    its(:exit_status) { should eq 0 }
  end

end
