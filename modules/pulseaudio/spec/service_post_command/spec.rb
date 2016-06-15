require 'spec_helper'

describe 'pulseaudio::service' do

  describe service('pulseaudio-dj') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('lightdm') do
    it { should be_running }
  end

end
