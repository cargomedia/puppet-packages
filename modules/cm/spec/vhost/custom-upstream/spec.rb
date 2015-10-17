require 'spec_helper'

describe 'cm::vhost' do
  describe file ('/etc/nginx/conf.d/foo-upstream.conf') do
    it { should be_file }
    its(:content) { should match /server localhost:9001/ }
  end

  describe file ('/etc/nginx/conf.d/fastcgi-backend-upstream.conf') do
    it { should be_file }
    its(:content) { should match /server localhost:8888/ }
    its(:content) { should match /server localhost:8889/ }
  end

  redirect_location = /< Location: https:\/\/www\.foo\.cm\//

  ['bar', 'bor', 'baz'].each do |name|
    describe command("curl --proxy '' -v http://#{name}.cm") do
      its(:stderr) { should match redirect_location }
    end
  end

  describe 'Checking if REMOTE_ADDR fcgi header is set to real ip address' do
    describe command("curl --proxy '' --interface eth0:0 -m 1 -kL https://foo.xx") do
    end
    describe file ('/var/log/spec_nc_log') do
      its(:content) { should match /REMOTE_ADDR192.168.199.199/ }
    end

  end

  ['www.', 'admin.', ''].each do |name|
    ['xx', 'cm'].each do |tld|
      describe command("curl --proxy '' -v http://#{name}foo.#{tld}") do
        its(:stderr) { should match /< Location: https:\/\/#{name}foo\.#{tld}\// }
      end
    end
  end
end
