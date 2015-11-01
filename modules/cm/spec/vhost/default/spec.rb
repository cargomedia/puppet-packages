require 'spec_helper'

describe 'cm::vhost' do

  # Redirects
  ['example1-redirect1.com', 'example1-redirect2.com', 'example1-redirect2.com'].each do |domain|
    describe command("curl --proxy '' -v http://#{domain}") do
      its(:stderr) { should match /< Location: https:\/\/example1\.com\// }
    end
  end

  # HTTPS -> HTTP redirects
  ['www.', 'admin.', ''].each do |prefix|
    ['example1.com', 'example2.com'].each do |domain|
      describe command("curl --proxy '' -v http://#{prefix}#{domain}") do
        its(:stderr) { should match /< Location: https:\/\/#{prefix}#{domain}\// }
      end
    end
  end

  # FastCGI upstream
  [
    'https://example1.com', 'https://www.example1.com', 'https://admin.example1.com',
    'https://example2.com', 'https://www.example2.com', 'https://admin.example2.com',
    'http://example3.com', 'http://www.example3.com', 'http://admin.example3.com',
  ].each do |url|
    describe command("curl --proxy '' -vk #{url}") do
      its(:stdout) { should match 'Hello World!' }
    end
  end

  # CDN Origin
  [
    'https://origin-www.example1.com',
    'https://www.example2.com',
    'http://origin-www.example3.com',
  ].each do |url|
    describe command("curl --proxy '' -vk #{url}/static/file.txt") do
      its(:stdout) { should match 'My Data' }
      its(:stderr) { should match /Access-Control-Allow-Origin	*/ }
    end
  end

end
