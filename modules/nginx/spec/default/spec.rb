require 'spec_helper'

describe 'nginx::default' do

  describe command('nginx -t') do
    its(:exit_status) { should eq 0 }
  end

  describe command('nginx -V') do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should match('--with-http_v2_module') }
    its(:stderr) { should match('built with OpenSSL 1.0.2') }   # See https://www.nginx.com/blog/supporting-http2-google-chrome-users/
  end

  describe command("curl --proxy '' 'http://localhost/server-status'") do
    its(:stdout) { should match 'Active connections: 1' }
  end

end
