require 'spec_helper'

describe 'cm::reverse_proxy' do

  describe 'Https proxy times out as expected' do
    describe command("curl --insecure --proxy '' --max-time 1 https://www.example.com") do
      its(:exit_status) { should eq 28 }
    end
  end

  describe 'Https backend gets a X-Real-IP request header' do
    describe file('/tmp/https.log') do
      its(:content) { should match /X-Real-IP: 127.0.0.1/ }
    end
  end

end
