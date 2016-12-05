require 'spec_helper'

describe 'nginx::bipbip_entry' do

  describe command('nginx -t') do
    its(:exit_status) { should eq 0 }
  end

  describe command('nginx -V') do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should match('built with OpenSSL 1.0.2') }
    its(:stderr) { should match('--with-http_v2_module') }
  end

  describe command("curl --proxy '' 'http://localhost/server-status'") do
    its(:stdout) { should match 'Active connections: 1' }
  end

end
