require 'spec_helper'

describe 'augeas' do

  describe package('libaugeas-ruby') do
    it { should be_installed }
  end

end
