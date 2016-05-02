require 'spec_helper'

describe 'nvidia' do

  describe package('nvidia-346') do
    it { should be_installed }
  end

end
