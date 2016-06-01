require 'spec_helper'

describe 'cm::vhost' do

  describe 'Redirects from all aliases and to https' do
    ['example1-redirect1.com', 'example1-redirect2.com', 'example1-redirect2.com'].each do |domain|
      describe command("curl --proxy '' --insecure --location --verbose http://#{domain}") do
        its(:stderr) { should match /< Location: https:\/\/example1\.com\// }
      end
    end
  end

  describe 'Redirects to https preserving the original host name' do
    ['www.', 'admin.', ''].each do |prefix|
      ['example1.com', 'example2.com'].each do |domain|
        describe command("curl --proxy '' --insecure --location --verbose http://#{prefix}#{domain}") do
          its(:stderr) { should match /< Location: https:\/\/#{prefix}#{domain}\// }
        end
      end
    end
  end

  describe 'Forwards request upstream to FastCGI' do
    [
        'https://example1.com', 'https://www.example1.com', 'https://admin.example1.com',
        'https://example2.com', 'https://www.example2.com', 'https://admin.example2.com',
        'http://example3.com', 'http://www.example3.com', 'http://admin.example3.com',
    ].each do |url|
      describe command("curl --proxy '' --insecure --location --verbose #{url}") do
        its(:stdout) { should match 'Hello World!' }
      end
    end
  end

  describe 'Serves correct content when requesting (e.g. CDN) origin' do
    [
        'https://origin-www.example1.com',
        'https://www.example2.com',
        'http://origin-www.example3.com',
    ].each do |url|
      describe command("curl --proxy '' --insecure --location --verbose #{url}/static/file.txt") do
        its(:stdout) { should match 'My Data' }
        its(:stderr) { should match /Access-Control-Allow-Origin	*/ }
      end
    end
  end
end
