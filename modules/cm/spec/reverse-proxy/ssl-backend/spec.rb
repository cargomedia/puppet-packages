require 'spec_helper'

describe 'cm::reverse-proxy::ssl-backend' do

  describe command("curl --proxy '' -v http://baz.xxx") do
    its(:stderr) { should match /< Location: https:\/\/foo\.xxx\// }
  end

  describe command("curl --proxy '' --location --insecure http://baz.xxx") do
    its(:stdout) { should match /foobar/ }
  end

  describe command("curl --proxy '' --insecure https://bar.xxx") do
    its(:stdout) { should match /foobar/ }
  end

  describe command("curl --proxy '' --insecure https://foo.xxx") do
    its(:stdout) { should match /foobar/ }
  end

end
