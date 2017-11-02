require 'spec_helper'

describe 'nginx::config_nginx_servernames_hash' do

  describe command('nginx -t') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/etc/nginx/nginx.conf') do
    its(:content) { should match /server_names_hash_bucket_size 64;/}
    its(:content) { should match /server_names_hash_max_size 1024;/}
  end
end
