require 'spec_helper'

describe 'puppet::db' do

  describe package('puppetdb') do
    it { should be_installed }
  end

  describe service('puppetdb') do
    it { should be_running }
    it { should be_enabled }
  end

  describe port(8080) do
    it { should be_listening }
  end

  describe port(8081) do
    it { should be_listening }
  end
end
