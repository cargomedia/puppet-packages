require 'spec_helper'

describe 'nginx proxy' do

  describe file('/etc/nginx/nginx.conf') do
    it { should be_file }
    its(:content) { should match /worker_processes(.*)6/ }
    its(:content) { should match /worker_rlimit_nofile(.*)20000/ }
    its(:content) { should match /worker_connections(.*)10000/ }
    its(:content) { should match /keepalive_timeout(.*)30/ }
    its(:content) { should match /access_log(.*)off/ }
    its(:content) { should_not match /server_names_hash_bucket_size/}
  end

  describe file('/etc/nginx/conf.d/proxy.conf') do
    it { should be_file }
  end

  describe file('/etc/nginx/conf.d/vhost_autogen.conf') do
    it { should be_file }
    its(:content) { should match /listen(.*)8090/ }
    its(:content) { should match /proxy_pass(.*)backend-socketredis/ }
    its(:content) { should match /proxy_buffering(.*)off/ }
  end

  describe file('/etc/nginx/conf.d/backend-socketredis-upstream.conf') do
    it { should be_file }
    its(:content) { should match /upstream(.*)backend-socketredis/ }
    its(:content) { should match /ip_hash/ }
    its(:content) { should match /server(.*)localhost:8096/ }
  end

  describe port(8090) do
    it { should be_listening }
  end

  describe command('openssl s_client -connect localhost:8090 | grep "CONNECTED"') do
    its(:exit_status) { should eq 0 }
  end
end
