require 'spec_helper'

describe 'ffmpeg' do

  describe file('/usr/local/bin/ffmpeg') do
    it { should be_executable }
  end
end
