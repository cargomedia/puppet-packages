require 'spec_helper'

describe 'snmp' do

  describe package('snmp') do
    it { should be_installed }
  end

  describe service('snmpd') do
    it { should be_enabled }
  end

  describe command('snmpwalk -v 2c -c fuboo localhost .iso.3.6.1.2.1.1.1.0 | grep Linux') do
    its(:exit_status) { should eq 0 }
  end

  describe command('snmpwalk -v 2c -c public localhost .iso.3.6.1.2.1.1.1.0 | grep Linux') do
    its(:exit_status) { should eq 1 }
  end

  ['/raid', '/foo'].each do |disk|
    describe file('/etc/snmp/snmpd.conf') do
      its(:content) { should match /disk #{disk}/ }
    end
  end
end
