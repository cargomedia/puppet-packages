require 'spec_helper'

describe 'augeas' do

  describe package('libaugeas-ruby') do
    it { should be_installed }
  end

  describe file('/tmp/foo') do
    it { should be_file }
    its(:content) { should match /foo=bar/ }
    its(:content) { should match /bar=42/ }
    its(:content) { should match /baz=22/ }
  end
end
