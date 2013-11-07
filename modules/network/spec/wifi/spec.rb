require 'spec_helper'

describe file('/etc/network/interfaces') do
  it { should be_file }
  it { should contain 'eth1' }
  it { should contain 'wpa-ssid foo' }
  it { should contain 'wpa-psk bar' }
end
