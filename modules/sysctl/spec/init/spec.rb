require 'spec_helper'

describe file('/etc/sysctl.conf') do
  it { should be_file }
end

entries = [
    'net.ipv4.tcp_synack_retries = 2',
    'net.ipv4.tcp_syncookies = 1',
    'vm.swappiness = 0',
]

describe file('/etc/sysctl.conf') do
  entries.each do |entry|
    its(:content) { should match /#{entry}/ }
  end
end

describe command('sysctl -a') do
  entries.each do |entry|
    its(:stdout) { should match /#{entry}/ }
  end
end