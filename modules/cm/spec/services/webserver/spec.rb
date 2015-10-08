require 'spec_helper'

describe 'cm::services::webserver' do

  describe command("curl --proxy '' 'http://localhost/server-status'") do
    its(:stdout) { should match 'Active connections: 1' }
  end

end
