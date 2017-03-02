require 'spec_helper'

describe 'cm::reverse_proxy::proxy-chain' do

  describe command("curl --proxy '' --insecure https://ssl.upfront") do
    its(:stdout) { should match /This is the final destination/ }
  end

  describe command("curl --proxy '' --insecure http://plain.text.middle:8081") do
    its(:stdout) { should match /This is the final destination/ }
  end

end
