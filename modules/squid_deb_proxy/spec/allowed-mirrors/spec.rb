require 'spec_helper'

describe 'squid_deb_proxy::allowed-mirrors' do

  describe file('/etc/squid-deb-proxy//mirror-dstdomain.acl.d/20-test') do
    its(:content) { should match /^foo\.com$/}
    its(:content) { should match /^example\.com$/}
  end
end
