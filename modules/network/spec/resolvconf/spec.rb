require 'spec_helper'

describe 'network::resolvconf' do

  describe package('resolvconf') do
    it { should be_installed }
  end

end
