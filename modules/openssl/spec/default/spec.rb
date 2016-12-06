require 'spec_helper'

describe 'openssl' do

  describe package('libssl-dev') do
    it { should be_installed }
  end

  describe command('openssl version') do
    its(:exit_status) { should eq 0 }
  end

end
