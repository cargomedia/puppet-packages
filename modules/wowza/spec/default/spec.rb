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