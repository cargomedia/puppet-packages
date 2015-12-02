require 'spec_helper'

describe 'nginx::bipbip_entry' do

  describe command("curl --proxy '' 'http://localhost/server-status'") do
    its(:stdout) { should match 'Active connections: 1' }
  end

end
