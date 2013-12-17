require 'spec_helper'

describe package('mysql-server') do
  it { should be_installed }
end

describe file('/etc/mysql/conf.d/master.cnf') do
  it { should be_file }
  its(:content) { should match 'server-id = 123'}
end
