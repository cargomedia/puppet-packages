require 'spec_helper'

describe package('php5-snmp') do
  it { should be_installed }
end
