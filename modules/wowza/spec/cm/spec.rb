require 'spec_helper'

describe package('wowzastreamingengine-4.0.3') do
  it { should be_installed }
end

describe file('/usr/local/WowzaStreamingEngine/lib/json-simple.jar') do
  it { should be_file }
  it { should be_linked_to '/usr/local/WowzaStreamingEngine/lib/lib-versions/json-simple-1.1.1.jar' }
end

describe file('/usr/local/WowzaStreamingEngine/lib/flexjson.jar') do
  it { should be_file }
  it { should be_linked_to '/usr/local/WowzaStreamingEngine/lib/lib-versions/flexjson-2.1.jar' }
end

describe file('/usr/local/WowzaStreamingEngine/lib/ch.cargomedia.wms.jar') do
  it { should be_file }
end

describe command('/usr/bin/unzip -tl /usr/local/WowzaStreamingEngine/lib/ch.cargomedia.wms.jar') do
  let(:pre_command) { 'apt-get install -qy unzip' }
  it { should return_exit_status 0 }
end

describe file('/etc/monit/conf.d/wowza') do
  it { should be_file }
end

describe command('sleep 10') do
  it { should return_exit_status 0 }
end

[1935,8083,8086].each do |port|
  describe port(port) do
    it { should be_listening }
  end
end

[8084,8085].each do |port|
  describe port(port) do
    it { should_not be_listening }
  end
end

describe command('curl http://localhost:8086/status') do
  its(:stdout) { should match /{}/ }
end
