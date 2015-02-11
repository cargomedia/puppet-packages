require 'spec_helper'

describe 'apache2' do

  describe package('apache2') do
    it { should be_installed }
  end
end
