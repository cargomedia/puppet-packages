require 'spec_helper'

describe 'xvfb' do

  describe package('xvfb') do
    it { should be_installed }
  end

end
