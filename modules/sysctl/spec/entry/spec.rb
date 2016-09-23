require 'spec_helper'

describe 'sysctl::entry' do

  describe command('sysctl -a') do
    its(:stdout) { should match 'net.ipv4.tcp_syncookies = 1' }
    its(:stdout) { should match 'net.core.somaxconn = 512' }
    its(:stdout) { should match 'net.ipv4.tcp_max_syn_backlog = 1024' }
  end
end
