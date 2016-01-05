require 'spec_helper'

describe 'ufw::ports' do

  describe iptables do
    it { should have_rule('-p tcp -m tcp --dport 80 -j DROP').with_table('filter').with_chain('ufw-user-input') }
    it { should have_rule('-p tcp -m tcp --dport 999 -j ACCEPT').with_table('filter').with_chain('ufw-user-input') }
    it { should have_rule('-p udp -m udp --dport 999 -j ACCEPT').with_table('filter').with_chain('ufw-user-input') }
  end
end
