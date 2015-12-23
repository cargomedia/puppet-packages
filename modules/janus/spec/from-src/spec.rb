require 'spec_helper'

describe 'janus::from_src' do

  describe user('janus') do
    it { should exist }
  end

  describe service('janus') do
    it { should be_enabled }
    it { should be_running }
  end
end
