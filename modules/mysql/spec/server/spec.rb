require 'spec_helper'

describe package('mysql-server') do
  it { should be_installed }
end

describe file('/etc/mysql/init.sql') do
  it { should be_file }
  it { should contain "UPDATE mysql.user SET Password=PASSWORD('foo') WHERE User='root';"}
end

describe file('/etc/mysql/debian.cnf') do
  it { should be_file }
  it { should contain 'password = bar' }
end
