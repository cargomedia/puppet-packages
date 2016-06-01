require 'spec_helper'

describe 'xorg' do

  describe package('xorg') do
    it { should be_installed }
  end

end
