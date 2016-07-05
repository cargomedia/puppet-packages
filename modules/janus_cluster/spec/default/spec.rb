require 'spec_helper'

describe 'cargomedia::janus_cluster' do

  describe service('janus_origin1') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('janus_repeater1') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('janus_repeater1-multiedge1') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('janus_repeater1-multiedge5') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('janus-cluster-manager') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('janus-cluster-member-origin1') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('janus-cluster-member-repeater1') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('janus-cluster-member-repeater1-multiedge1') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('janus-cluster-member-repeater1-multiedge5') do
    it { should be_enabled }
    it { should be_running }
  end

  describe file('/opt/janus-cluster/repeater1-multiedge1/etc/janus/janus.cfg') do
    its(:content) { should match /^rtp_port_range = 31000-34799$/ }
  end

  describe file('/opt/janus-cluster/repeater1-multiedge5/etc/janus/janus.plugin.cm.rtpbroadcast.cfg') do
    its(:content) { should match /^maxport=25001$/ }
  end

  describe command ('netstat -tnalp |grep -E "LISTEN+.+janus"') do
    its(:stdout) { should match /8000+.+LISTEN/ }
    its(:stdout) { should match /8010+.+LISTEN/ }
    its(:stdout) { should match /9000+.+LISTEN/ }
    its(:stdout) { should match /9010+.+LISTEN/ }
    its(:stdout) { should match /1150[1-5]+.+LISTEN/ }
    its(:stdout) { should match /1171[1-5]+.+LISTEN/ }
  end
end
