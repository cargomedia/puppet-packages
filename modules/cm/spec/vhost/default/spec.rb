require 'spec_helper'

describe 'cm::vhost' do

  # Redirects
  ['example2-redirect1.com', 'example2-redirect2.com', 'example2-redirect2.com'].each do |domain|
    describe command("curl --proxy '' -v http://#{domain}") do
      its(:stderr) { should match /< Location: https:\/\/www\.example2\.com\// }
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
  ['www.', 'admin.', ''].each do |prefix|
    ['example1.com', 'example2.com'].each do |domain|
      describe command("curl --proxy '' -vk https://#{prefix}#{domain}") do
        its(:stdout) { should match 'Hello World!' }
      end
    end
  end

  # CDN Origin
  [
    'http://origin-www.example1.com', 'https://origin-www.example1.com',
    'http://origin-www.example2.com', 'https://origin-www.example2.com',
  ].each do |url|
    describe command("curl --proxy '' -vk #{url}/static/file.txt") do
      its(:stdout) { should match 'My Data' }
      its(:stderr) { should match /Access-Control-Allow-Origin	*/ }
    end
  end

end
