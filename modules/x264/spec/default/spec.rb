require 'spec_helper'

describe 'x264' do

  describe file('/usr/local/bin/x264') do
    it { should be_executable }
  end
end
