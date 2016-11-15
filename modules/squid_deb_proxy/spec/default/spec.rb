require 'spec_helper'

describe 'squid_deb_proxy::default' do

  describe package('squid-deb-proxy') do
    it { should be_installed }
  end

  describe port(8123) do
    it { should be_listening }
  end

  describe file('/var/log/squid-deb-proxy/access.log') do
    its(:content) { should match /TCP+_MEM?_HIT+.+htop_+.+\.deb/ }
  end
end
