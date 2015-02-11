require 'spec_helper'

describe 'polipo' do

  describe package('polipo') do
    it { should be_installed }
  end

  describe file('/etc/polipo/config') do
    its(:content) { should match /diskCacheRoot = "\/tmp\/foo"/ }
  end
end
