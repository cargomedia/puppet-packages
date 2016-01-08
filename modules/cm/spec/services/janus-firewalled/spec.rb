require 'spec_helper'

describe 'cm::services::janus-firewalled' do

  describe iptables do
    it { should have_rule('-p tcp -m multiport --dports 8100,8110').with_table('filter').with_chain('ufw-user-input') }
    it { should have_rule('-p udp -m multiport --dports 10000:15000').with_table('filter').with_chain('ufw-user-input') }
  end
end
