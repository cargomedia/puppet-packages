require 'spec_helper'

describe 'unzip' do

  describe package('unzip') do
    it { should be_installed }
  end
end
