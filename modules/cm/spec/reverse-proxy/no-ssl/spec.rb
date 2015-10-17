require 'spec_helper'

describe 'cm::reverse_proxy' do

  describe command("curl --proxy '' http://bar.xxx:9595") do
    its(:stdout) { should match /foobar/ }
  end

  describe command("curl --proxy '' http://proxy.xxx") do
    its(:stdout) { should match /foobar/ }
  end


end
