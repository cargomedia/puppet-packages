require 'spec_helper'

describe 'cm::vhost' do

  describe 'REMOTE_ADDR fcgi header is set to real ip address' do
    describe command("curl --proxy '' --header 'X-Real-IP: 1.2.3.4' --insecure https://www.example.com") do
      its(:stdout) { should match /your ip: 1.2.3.4/ }
    end
  end

  describe 'Nginx validates the X-Real-IP header' do
    describe command("curl --proxy '' --header 'X-Real-IP: foo' --location --insecure http://www.example.com") do
      its(:stdout) { should match /your ip: 127.0.0.1/ }
    end

    describe command("curl --proxy '' --header 'X-Real-IP: 1.2.3.4foo' --location --insecure http://www.example.com") do
      its(:stdout) { should match /your ip: 127.0.0.1/ }
    end
  end

  describe 'REMOTE_ADDR is passed by default' do
    describe command("curl --proxy '' --location --insecure http://www.example.com") do
      its(:stdout) { should match /your ip: 127.0.0.1/ }
    end
  end

end
