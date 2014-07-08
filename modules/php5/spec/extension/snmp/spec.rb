require 'spec_helper'

describe package('php5-snmp') do
  it { should be_installed }
end

describe command('php --ri snmp') do
  it { should return_exit_status 0 }
end

describe file('/var/log/php/error.log') do
  its(:content) { should_not match /Warning.*snmp.*already loaded/ }
end
