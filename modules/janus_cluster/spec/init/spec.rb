require 'spec_helper'

describe 'janus_cluster' do

  describe service('janus-cluster') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(8801) do
    it { should be_listening }
  end
end
