require 'spec_helper'

describe 'cm::reverse_proxy' do

  describe command("curl --insecure --proxy '' --max-time 1 https://www.example.com") do
    its(:exit_status) { should eq 28 }
  end

  describe file('/tmp/https.log') do
    its(:content) { should match /X-Real-IP: 127.0.0.1/ }
  end
end
