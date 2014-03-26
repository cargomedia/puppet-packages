require 'spec_helper'

describe package('snmp') do
  it { should be_installed }
end

describe service('snmpd') do
  it { should be_enabled }
end

describe service('monit') do
  it { should be_enabled }
end

describe command('snmpwalk -v 2c -c fuboo localhost .iso.3.6.1.2.1.1.1.0 | grep Linux') do
	it { should return_exit_status 0 }
end

describe command('snmpwalk -v 2c -c public localhost .iso.3.6.1.2.1.1.1.0 | grep Linux') do
	it { should return_exit_status 1 }
end

describe command('monit summary') do
  its(:stdout) { should match /Process 'snmpd'/ }
end

['/raid', '/foo'].each do |disk|
	describe file('/etc/snmp/snmpd.conf') do
		its(:content) { should match /disk #{disk}/ }
	end
end
