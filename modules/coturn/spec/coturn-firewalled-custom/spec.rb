require 'spec_helper'

describe 'coturn - firewalled with custom rules' do

  describe iptables do
    it { should have_rule('-p tcp -m multiport --dports 10,15,22,189,3479').with_table('filter').with_chain('ufw-user-input') }
    it { should have_rule('-p udp -m multiport --dports 120:400').with_table('filter').with_chain('ufw-user-input') }
  end
end
