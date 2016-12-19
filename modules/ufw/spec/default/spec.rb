require 'spec_helper'

describe 'ufw::default' do

  describe package('ufw') do
    it { should be_installed }
  end

  describe iptables do
    it { should have_rule('-s 10.0.0.0/8').with_table('filter').with_chain('ufw-before-input') }
    it { should have_rule('-s 172.16.0.0/12').with_table('filter').with_chain('ufw-before-input') }
    it { should have_rule('-s 192.168.0.0/16').with_table('filter').with_chain('ufw-before-input') }
  end

  #ensure there is still network connectivity
  describe command('ping -c 3 google.com') do
    its(:exit_status) { should eq 0 }
  end

  describe command('curl -s google.com') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/etc/default/ufw') do
    it { should be_file }
    its(:content) { should match /IPV6=no/ }
  end
end
