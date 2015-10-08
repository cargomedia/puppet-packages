require 'spec_helper'

describe 'cm::vhost' do
  redirect_location = /< Location: https:\/\/www\.foo\.cm\//

  ['bar', 'bor', 'baz'].each do |name|
    describe command("curl --proxy '' -v http://#{name}.cm") do
      its(:stderr) { should match redirect_location }
    end
  end

  ['www.', 'admin.', ''].each do |name|
    ['xx', 'cm'].each do |tld|
      describe command("curl --proxy '' -v http://#{name}foo.#{tld}") do
        its(:stderr) { should match /< Location: https:\/\/#{name}foo\.#{tld}\// }
      end
    end
  end

  describe file ('/etc/nginx/conf.d/foo-upstream.conf') do
    it { should be_file }
    its(:content) { should match /server localhost:9000/ }
    its(:content) { should match /server localhost:9001/ }
  end

  describe file ('/etc/nginx/conf.d/fastcgi-backend-upstream.conf') do
    it { should be_file }
    its(:content) { should match /server localhost:8888/ }
    its(:content) { should match /server localhost:8889/ }
  end
end
