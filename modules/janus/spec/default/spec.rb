require 'spec_helper'

describe 'janus' do

  describe user('janus') do
    it { should exist }
  end

  describe service('janus') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port (8088) do
    it { should be_listening }
  end

  describe port (8188) do
    it { should be_listening }
  end
end
