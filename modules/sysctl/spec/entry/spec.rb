require 'spec_helper'

describe command('sysctl -a') do
  its(:stdout) { should match 'net.ipv4.tcp_syncookies = 1' }
end
