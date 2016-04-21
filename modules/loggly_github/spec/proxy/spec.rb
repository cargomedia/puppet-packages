require 'spec_helper'

describe 'loggly_github::proxy' do

  describe command("curl -v --data '' --proxy '' -k http://www.cm.dev:1235") do
    its(:stderr) { should match('< Location: https://www.cm.dev:1235/') }
  end

  describe command("curl --data '' --proxy '' -k https://www.cm.dev:1235") do
    its(:stdout) { should match('Cannot POST /') }
  end

end
