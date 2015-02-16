require 'spec_helper'

describe 'vagrant' do

  describe package('vagrant') do
    it { should be_installed }
  end
end
