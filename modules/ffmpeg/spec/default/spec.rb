require 'spec_helper'

describe file('/usr/local/bin/ffmpeg') do
  it { should be_executable }
end
