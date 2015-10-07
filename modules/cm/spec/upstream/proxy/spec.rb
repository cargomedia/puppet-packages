require 'spec_helper'

describe 'cm::upstream::proxy' do

  describe file ('/etc/nginx/conf.d/reverse-proxy-backend-upstream.conf') do
    it { should be_file }
    its(:content) { should match /server localhost:443/ }
    its(:content) { should match /server localhost:444/ }
  end
  describe file ('/etc/nginx/conf.d/reverse-proxy-another-one-upstream.conf') do
    it { should be_file }
    its(:content) { should match /server foo\.test:8080/ }
  end
end
