require 'spec_helper'

describe 'network::wpa_supplicant' do

  describe package('wpasupplicant') do
    it { should be_installed }
  end
end
