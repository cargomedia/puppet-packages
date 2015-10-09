require 'spec_helper'

describe 'cm::vhost' do

  describe command("curl --proxy '' http://foobar") do
    its(:stdout) { should match /foobar/ }
  end

  describe command("curl --proxy '' http://alicebob") do
    its(:stdout) { should match /alice and bob/ }
  end

end
