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
        its(:stdout) { should match /Hello World!/ }
      end
    end
  end

end
