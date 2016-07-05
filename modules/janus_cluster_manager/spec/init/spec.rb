require 'spec_helper'

describe 'janus_cluster_manager' do

  describe service('janus-cluster-manager') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(8801) do
    it { should be_listening }
  end
end
