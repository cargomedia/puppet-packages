require 'spec_helper'

describe 'ffmpeg' do

  describe command('/usr/bin/ffmpeg -version') do
    its(:exit_status) { should eq 0 }
  end

end
