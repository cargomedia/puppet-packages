require 'spec_helper'

describe 'ssh' do

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /PermitRootLogin without-password/ }
  end

  describe iptables do
    it { should have_rule('-p tcp -m tcp --dport 22').with_table('filter').with_chain('ufw-user-input') }
  end
end
