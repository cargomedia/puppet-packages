require 'spec_helper'

describe 'ufw::default' do

  describe iptables do
    it { should have_rule('-m comment --comment "foo bar rule"').with_table('filter').with_chain('ufw-before-input') }
  end

  #ensure there is still network connectivity
  describe command('ping -c 3 google.com') do
    its(:exit_status) { should eq 0 }
  end

  describe command('curl -s google.com') do
    its(:exit_status) { should eq 0 }
  end
end
