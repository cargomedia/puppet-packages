require 'spec_helper'

describe 'cm::services::janus-firewalled-custom' do

  describe iptables do
    it { should have_rule('-p tcp -m multiport --dports 44:44000').with_table('filter').with_chain('ufw-user-input') }
    it { should have_rule('-p udp -m multiport --dports 10000:60000').with_table('filter').with_chain('ufw-user-input') }
  end
end
