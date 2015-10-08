require 'spec_helper'

describe 'cm::vhost' do

  describe command("curl --proxy '' -L http://bar.xxx") do
    its(:stdout) { should match /foobar/ }
  end

  describe command("curl --proxy '' -v http://baz.xxx") do
    its(:stderr) { should match /< Location: http:\/\/foo\.xxx\// }
  end

  describe command("curl --proxy '' -L http://baz.xxx") do
    its(:stdout) { should match /foobar/ }
  end

  describe command("curl --proxy '' -k https://bar.xxx") do
    its(:stdout) { should match /foobar/ }
  end

  describe command("curl --proxy '' -k https://foo.xxx") do
    its(:stdout) { should match /foobar/ }
  end

end
