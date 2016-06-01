require 'spec_helper'

describe 'openssl' do

  describe package('libssl-dev') do
    it { should be_installed }
  end

end
