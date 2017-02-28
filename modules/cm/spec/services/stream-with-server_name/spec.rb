require 'spec_helper'

describe 'cm::services::stream' do

  describe command("curl --proxy '' --insecure 'https://example.dev/'") do
    its(:stdout) { should match 'Welcome to SockJS!' }
  end

end
