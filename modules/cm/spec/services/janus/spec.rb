require 'spec_helper'

describe 'cm::services::janus' do

  describe port(8100) do
    it { should be_listening }
  end

  describe service('cm-janus_standalone') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('janus_standalone') do
    it { should be_enabled }
    it { should be_running }
  end
end
