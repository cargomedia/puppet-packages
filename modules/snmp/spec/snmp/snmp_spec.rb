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

describe command('snmpwalk -v 2c -c fuckbook 127.0.0.1 .iso.3.6.1.2.1.1.1.0 | grep Linux') do
	it { should return_exit_status 0 }
end

describe command('snmpwalk -v 2c -c public 127.0.0.1 .iso.3.6.1.2.1.1.1.0 | grep Linux') do
	it { should return_exit_status 1 }
end

describe command('monit summary | grep snmpd.*running') do
	it { should return_exit_status 0 }
end
