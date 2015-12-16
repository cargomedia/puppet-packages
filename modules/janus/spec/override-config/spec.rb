require 'spec_helper'

describe 'janus::service::override-config' do

  describe port (55555) do
    it {should be_listening}
  end

  describe port (55556) do
    it {should be_listening}
  end
  #
  # describe command('cat /var/log/syslog') do
  #   its(:stdout) { should match /janus+.*Reading configuration from \/tmp\/januxx\.foo\.conf/ }
  #   its(:stdout) { should match /janus+.*configs_folder: \/tmp/ }
  #   its(:stdout) { should match /janus+.*Configuration file: \/tmp\/janus\.plugin\.cm\.rtpbroadcast\.cfg/ }
  #   its(:stdout) { should match /janus+.*Configuration file: \/tmp\/janus\.transport\.websockets\.cfg/ }
  #   its(:stdout) { should match /janus+.*Configuration file: \/tmp\/janus\.transport\.http\.cfg/ }
  # end
end
