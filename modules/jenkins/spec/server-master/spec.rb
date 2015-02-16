require 'spec_helper'

describe 'jenkins server-master' do

  describe package('jenkins') do
    it { should be_installed }
  end

  describe file('/var/lib/jenkins/credentials.xml') do
    its(:content) { should match '<id>cluster-credential</id>' }
  end
end
