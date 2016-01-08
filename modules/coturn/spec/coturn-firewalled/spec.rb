require 'spec_helper'

describe 'coturn - firewalled default' do

  describe iptables do
    it { should have_rule('-p tcp -m multiport --dports 3478,3479,49152:65535').with_table('filter').with_chain('ufw-user-input') }
    it { should have_rule('-p udp -m multiport --dports 3478,3479,49152:65535').with_table('filter').with_chain('ufw-user-input') }
  end
end
