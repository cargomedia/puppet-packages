require 'spec_helper'

describe 'mysql::server' do

  describe package('mysql-server') do
    it { should be_installed }
  end

  describe file('/etc/mysql/init.sql') do
    it { should be_file }
    its(:content) { should match /^UPDATE mysql.user SET Password=PASSWORD\('foo'\) WHERE User='root'/ }
  end

  describe file('/etc/mysql/debian.cnf') do
    it { should be_file }
    its(:content) { should match('password = bar') }
  end

  describe command('mysql -e "show status"') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match('Uptime') }
  end
end
