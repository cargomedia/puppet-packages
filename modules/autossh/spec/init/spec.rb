require 'spec_helper'

describe 'autossh' do

  describe package('autossh') do
    it { should be_installed }
  end
end
