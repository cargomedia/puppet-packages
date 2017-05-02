require 'spec_helper'

describe 'java::jre_headless' do

  describe package('openjdk-8-jre-headless') do
    it { should be_installed }
  end

end
