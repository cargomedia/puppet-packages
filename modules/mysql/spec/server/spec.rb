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
    its(:stdout) { should match('Uptime') }
  end

  describe command('mysql -e "show variables"' ) do
    its(:stdout) { should match /key_buffer_size.+8388608$/ }
    its(:stdout) { should match /thread_cache_size.+20$/ }
    its(:stdout) { should match /max_connections.+10$/ }
  end

  describe file('/var/log/mysql-slow-query.log') do
    it "owned by user mysql" do
      expect(subject).to be_owned_by('mysql')
    end
  end

  describe command('grep -h slow /tmp/dump/*') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /"seconds_query":1.100/ }
  end

  describe command('grep -h "\"level\":\"info" /tmp/dump/*') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /"message":"InnoDB:.+started/ }
  end
end
