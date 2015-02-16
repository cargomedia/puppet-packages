require 'spec_helper'

describe 'virtualbox' do

  describe package('virtualbox-4.3') do
    it { should be_installed }
  end
end
