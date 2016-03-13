require 'spec_helper'

describe 'janus::from_src' do

  describe user('janus') do
    it { should exist }
  end

  describe service('janus') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(8310) do
    it { should be_listening }
  end

  describe file('/opt/janus/janus-gateway-audioroom') do
    it { should be_directory }
  end

  describe file('/opt/janus/janus-gateway-rtpbroadcast') do
    it { should be_directory }
  end
end
