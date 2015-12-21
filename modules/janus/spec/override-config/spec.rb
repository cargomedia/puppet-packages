require 'spec_helper'

describe 'janus::service::override-config' do

  describe port (55555) do
    it {should be_listening}
  end

  describe port (55556) do
    it {should be_listening}
  end

  describe command('cat /var/log/janus/janus.log') do
    its(:stdout) { should match /Reading configuration from \/tmp\/januxx\.foo\.conf/ }
    its(:stdout) { should match /configs_folder: \/tmp/ }
    its(:stdout) { should match /Configuration file: \/tmp\/janus\.plugin\.cm\.rtpbroadcast\.cfg/ }
    its(:stdout) { should match /Configuration file: \/tmp\/janus\.transport\.websockets\.cfg/ }
    its(:stdout) { should match /Configuration file: \/tmp\/janus\.transport\.http\.cfg/ }
  end
end
