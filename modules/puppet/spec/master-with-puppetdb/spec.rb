require 'spec_helper'

describe 'puppet::master with puppetdb' do

  describe package('puppetmaster') do
    it { should be_installed }
  end

  describe package('puppetdb') do
    it { should be_installed }
  end
end
