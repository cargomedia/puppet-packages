require 'spec_helper'

describe package('mysql-server') do
  it { should be_installed }
end

describe file('/etc/mysql/conf.d/slave.cnf') do
  it { should be_file }
  its(:content) { should match 'server-id = 321'}
end
