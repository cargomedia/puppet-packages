require 'spec_helper'

describe 'cm_janus::proxy' do

  describe command('curl -k https://foo:7999') do

  end

  describe file ('/etc/nginx/conf.d/janus-upstream.conf') do
    it { should be_file }
    its(:content) { should match /server 127\.0\.0\.1:8180/ }
  end

end
