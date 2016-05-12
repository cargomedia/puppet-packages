require 'spec_helper'

describe 'pulseaudio' do

  describe package('pulseaudio') do
    it { should be_installed }
  end

  describe service('pulseaudio-dj') do
    it { should be_enabled }
    it { should be_running }
  end

  describe command('sudo -u dj -H sh -c "pacmd list-cards"') do
    its(:stdout) { should match /0 card\(s\) available./ }
    its(:exit_status) { should eq 0 }
  end

end
