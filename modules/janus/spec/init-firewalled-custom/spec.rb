require 'spec_helper'


describe 'janus - firewalled custom' do

  describe iptables do
    it { should have_rule('-p tcp -m multiport --dports 22,44,25000:30000').with_table('filter').with_chain('ufw-user-input') }
    it { should have_rule('-p udp -m multiport --dports 25000:30000').with_table('filter').with_chain('ufw-user-input') }
  end
end
