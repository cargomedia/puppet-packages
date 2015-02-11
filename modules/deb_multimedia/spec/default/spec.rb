require 'spec_helper'

describe 'deb_multimedia' do

  describe package('deb-multimedia-keyring') do
    it { should be_installed }
  end
end
