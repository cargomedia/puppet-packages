require 'spec_helper'

describe 'cm::vhost' do

  describe 'Checking if REMOTE_ADDR fcgi header is set to real ip address' do
    describe command("curl --proxy '' -H 'X-Real-IP: 1.2.3.4' http://www.example.com") do
      its(:stdout) { should match /your ip: 1.2.3.4/ }
    end
  end

  describe 'Checking if REMOTE_ADDR is passed by default' do
    describe command("curl --proxy '' http://www.example.com") do
      its(:stdout) { should match /your ip: 127.0.0.1/ }
    end
  end

end
