require 'spec_helper'

describe 'janus_cluster_manager::member' do

  describe file('/usr/bin/register-janus-cluster-member') do
    it { should be_file }
    its(:content) { should match /curl -X POST -H "Content-Type:application\/json" -d \\{\\"id\\":\\"node-id\\",\\"webSocketAddress\\":\\"ws:\/\/node-address\\",\\"data\\":\\{\\"rtpbroadcast\\":\\{\\"role\\":\\"repeater\\",\\"upstream\\":\\"upstream-id\\"\\}\\}\\} http:\/\/cluster-manager\/register/ }
  end

  describe service('janus-cluster-member') do
    it { should be_enabled }
    it { should be_running }
  end
end
