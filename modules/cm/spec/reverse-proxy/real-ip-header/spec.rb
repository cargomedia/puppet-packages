require 'spec_helper'

describe 'cm::reverse_proxy' do

  describe command('nc -lp 1337 > /tmp/http.log &') do
    its(:exit_status) { should eq 0 }
  end

  describe command("curl --proxy '' --max-time 1 http://www.example.com") do
    its(:exit_status) { should eq 28 }
  end

  describe file('/tmp/http.log') do
    its(:content) { should match /X-Real-IP: 127.0.0.1/ }
  end

end
