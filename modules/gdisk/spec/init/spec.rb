require 'spec_helper'

describe 'gdisk' do

  describe package('gdisk') do
    it { should be_installed }
  end
end
