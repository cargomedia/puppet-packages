require 'spec_helper'

describe 'yasm' do

  describe file('/usr/local/bin/yasm') do
    it { should be_executable }
  end
end
