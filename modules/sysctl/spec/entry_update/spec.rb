require 'spec_helper'

describe 'sysctl::entry_update' do

  describe command('sysctl -a') do
    its(:stdout) { should match 'net.ipv4.tcp_max_syn_backlog = 2048' }
  end
end
