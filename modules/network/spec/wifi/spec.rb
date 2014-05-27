require 'spec_helper'

describe file('/etc/network/interfaces') do
  it { should be_file }
  its(:content) { should match('eth1') }
  its(:content) { should match('wpa-ssid foo') }
  its(:content) { should match('wpa-psk bar') }
end
