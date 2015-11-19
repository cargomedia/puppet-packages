require 'spec_helper'

describe 'cm_janus::proxy' do

  describe file ('/etc/nginx/conf.d/janus-upstream.conf') do
    it { should be_file }
    its(:content) { should match /server 127\.0\.0\.1:8180/ }
  end

  describe command("curl --proxy '' -k https://foo:7999") do
    its(:stdout) { should match /^Upgrade Required/ }
  end

end
