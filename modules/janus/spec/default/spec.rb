require 'spec_helper'

describe 'janus' do

  describe user('janus') do
    it { should exist }
  end

  describe service('janus') do
    it { should be_enabled }
    it { should be_running }
  end

  describe file('/etc/janus/janus.plugin.audioroom.cfg.sample')
    it { should be_listening }
  end
end
