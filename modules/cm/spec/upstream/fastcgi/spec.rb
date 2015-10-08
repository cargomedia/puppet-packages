require 'spec_helper'

describe 'cm::upstream::fastcgi' do

  describe file ('/etc/nginx/conf.d/fastcgi-farm-upstream.conf') do
    it { should be_file }
    its(:content) { should match /server 192\.168\.1\.1:443/ }
    its(:content) { should match /server 192\.168\.1\.2/ }
  end
  describe file ('/etc/nginx/conf.d/fastcgi-upstream-upstream.conf') do
    it { should be_file }
    its(:content) { should match /server foo\.test\.bar:8080/ }
  end
end
