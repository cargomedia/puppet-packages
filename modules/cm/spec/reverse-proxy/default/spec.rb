require 'spec_helper'

describe 'cm::reverse_proxy' do

  describe 'Upstream server is responding correctly' do
    describe command("curl --proxy '' http://bar.xxx:9595") do
      its(:stdout) { should match /foobar/ }
    end
  end

  describe 'Https proxy routes request to upstream' do
    describe command("curl --insecure --proxy '' https://proxy.xxx") do
      its(:stdout) { should match /foobar/ }
    end
  end

  describe 'Http proxy enforces https and routes request to upstream' do
    describe command("curl --location --insecure --proxy '' http://proxy.xxx") do
      its(:stdout) { should match /foobar/ }
    end
  end

end
