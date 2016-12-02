require 'spec_helper'

describe 'nginx::http2' do

  describe command('nginx -V') do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should match('built with OpenSSL 1.0.2') }
  end

end
