require 'spec_helper'

describe 'build::cmake' do

  describe package('cmake') do
    it { should be_installed }
  end

end
