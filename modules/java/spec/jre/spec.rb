require 'spec_helper'

describe 'java::jre' do

  describe package('openjdk-8-jre') do
    it { should be_installed }
  end

end
