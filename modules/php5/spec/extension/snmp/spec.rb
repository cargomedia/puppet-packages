require 'spec_helper'

describe package('php5-snmp') do
  it { should be_installed }
end

describe command('php --ri snmp') do
  it { should return_exit_status 0 }
  its(:stdout) { should_not match /Warning.*snmp.*loaded/ }
end
