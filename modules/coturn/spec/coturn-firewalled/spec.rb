require 'spec_helper'

describe 'coturn - firewalled default' do

  describe iptables do
    it { should have_rule('-p tcp -m multiport --dports 3478,8540').with_table('filter').with_chain('ufw-user-input') }
  end
end
