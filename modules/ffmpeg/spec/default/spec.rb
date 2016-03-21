require 'spec_helper'

describe 'ffmpeg' do

  describe package('ffmpeg-cm') do
    it { should be_installed }
  end

  describe command('/usr/bin/ffmpeg -version') do
    its(:exit_status) { should eq 0 }
  end

end
