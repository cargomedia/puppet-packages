require 'spec_helper'

describe 'iptables' do

  describe package('iptables') do
    it { should be_installed }
  end

  describe iptables do
    it { should have_rule('-o foo1 -j MASQUERADE').with_table('nat').with_chain('POSTROUTING') }
  end

  describe iptables do
    it { should have_rule('-i bar1 -j REJECT').with_table('filter').with_chain('INPUT') }
  end
end
