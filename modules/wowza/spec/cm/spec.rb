require 'spec_helper'

describe package('wowzamediaserver-3.5.0') do
  it { should be_installed }
end

describe file('/usr/local/WowzaMediaServer/lib/json-simple-1.1.1.jar') do
  it { should be_file }
end

describe file('/usr/local/WowzaMediaServer/lib/flexjson-2.1.jar') do
  it { should be_file }
end

describe file('/usr/local/WowzaMediaServer/lib/ch.cargomedia.wms-0.0.1.jar') do
  it { should be_file }
end

describe command('/usr/bin/unzip -tl /usr/local/WowzaMediaServer/lib/ch.cargomedia.wms-0.0.1.jar') do
  let(:pre_command) { 'apt-get install -qy unzip' }
  it { should return_exit_status 0 }
end

describe file('/etc/monit/conf.d/wowza') do
  it { should be_file }
end

describe command('sleep 10') do
  it { should return_exit_status 0 }
end

describe port(1935) do
  it { should be_listening }
end

describe port(8086) do
  it { should be_listening }
end
