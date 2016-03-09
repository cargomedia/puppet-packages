require 'spec_helper'

describe 'cm::services::janus' do

  describe port(8100) do
    it { should be_listening }
  end

  describe port(18100) do
    it { should be_listening }
  end

  describe service('cm-janus_standalone1') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('cm-janus_standalone2') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('janus') do
    it { should_not be_enabled }
  end

  describe service('janus_standalone1') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('janus_standalone2') do
    it { should be_enabled }
    it { should be_running }
  end
end
