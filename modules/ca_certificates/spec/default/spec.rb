require 'spec_helper'

describe 'ca_certificates' do

  describe package('ca-certificates') do
    it { should be_installed }
  end

end
