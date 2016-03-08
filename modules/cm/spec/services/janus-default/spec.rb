require 'spec_helper'

describe 'cm::services::janus' do

  describe service('cm-janus_default') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('janus_default') do
    it { should be_enabled }
    it { should be_running }
  end
end
