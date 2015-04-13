require 'spec_helper'

describe 'cm::services::stream' do

  describe command("curl --proxy '' --insecure 'https://example.dev:8090/'") do
    its(:stdout) { should match 'Welcome to SockJS!' }
  end

end
