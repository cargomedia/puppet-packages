require 'spec_helper'

describe 'bluetooth' do

  describe package('bluetooth') do
    it { should be_installed }
  end

  describe package('bluez') do
    it { should be_installed }
  end

  describe package('bluez-alsa') do
    it { should be_installed }
  end

  describe file('/etc/bluetooth/audio.conf') do
    its(:content) { should match /AutoConnect=true/ }
    its(:content) { should match /FastConnectable=true/ }
  end
end
