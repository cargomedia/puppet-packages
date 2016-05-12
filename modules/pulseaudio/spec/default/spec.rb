require 'spec_helper'

describe 'pulseaudio' do

  describe package('pulseaudio') do
    it { should be_installed }
  end

end
