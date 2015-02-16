require 'spec_helper'

describe 'jenkins::job' do

  describe file('/var/lib/jenkins/jobs/foo/config.xml') do
    it { should be_file }
    it { should be_owned_by 'jenkins' }
    its(:content) { should match('foo') }
  end

  describe file('/var/lib/jenkins/jobs/bar/config.xml') do
    it { should be_file }
    it { should be_owned_by 'jenkins' }
    its(:content) { should match('bar') }
  end
end
