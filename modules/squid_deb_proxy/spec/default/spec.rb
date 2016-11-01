require 'spec_helper'

describe 'squid_deb_proxy::default' do

  describe package('squid-deb-proxy') do
    it { should be_installed }
  end

  describe port(8123) do
    it { should be_listening }
  end
end
