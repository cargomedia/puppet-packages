require 'spec_helper'

describe 'pulseaudio::module::bluetooth' do

  describe package('pulseaudio-module-bluetooth') do
    it { should be_installed }
  end

end
