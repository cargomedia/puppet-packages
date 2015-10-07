require 'spec_helper'

describe 'cm::vhost' do

  describe command("curl --proxy '' -k https://bar.xxx") do
    its(:stdout) { should match /foobar/ }
  end

  describe command("curl --proxy '' -k https://foo.xxx") do
    its(:stdout) { should match /foobar/ }
  end

end
