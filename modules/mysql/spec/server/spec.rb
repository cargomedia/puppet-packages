require 'spec_helper'

describe 'mysql::server' do

  describe package('mysql-server') do
    it { should be_installed }
  end

  describe file('/etc/mysql/init.sql') do
    it { should be_file }
    its(:content) { should match /^UPDATE mysql.user SET authentication_string=PASSWORD\('foo'\), password_expired = 'N' WHERE User='root'/ }
  end

  describe file('/etc/mysql/debian.cnf') do
    it { should be_file }
    its(:content) { should match('password = bar') }
  end

  describe command('mysql --version') do
    its(:stdout) { should match /\s5\.7\.[0-9]+/ }
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

end
