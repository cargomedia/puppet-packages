require 'spec_helper'

describe package('mysql-server') do
  it { should be_installed }
end

describe file('/etc/mysql/init.sql') do
  it { should be_file }
  its(:content) { should match("UPDATE mysql.user SET Password=PASSWORD('foo') WHERE User='root';")}
end

describe file('/etc/mysql/debian.cnf') do
  it { should be_file }
  its(:content) { should match('password = bar') }
end

describe command('/etc/init.d/mysql status') do
  it { should return_exit_status 0 }
  its(:stdout) { should match('Uptime') }
end

describe command('mysql -e "show status"') do
  it { should return_exit_status 0 }
  its(:stdout) { should match('Uptime') }
end
