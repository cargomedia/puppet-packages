require 'spec_helper'

describe 'janus::cluster' do

  describe user('janus') do
    it { should exist }
  end

  describe service('janus') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('janus_edge3') do
    it { should be_enabled }
    it { should be_running }
  end
end
