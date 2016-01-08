require 'spec_helper'

describe 'janus - firewalled default' do

  describe iptables do
    it { should have_rule('-p tcp -m multiport --dports 20000:25000').with_table('filter').with_chain('ufw-user-input') }
    it { should have_rule('-p udp -m multiport --dports 20000:25000').with_table('filter').with_chain('ufw-user-input') }
  end
end

