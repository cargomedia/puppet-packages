require 'spec_helper'

describe 'mysql_proxy' do

  describe package('mysql-proxy') do
    it { should be_installed }
  end

  describe command('monit summary') do
    its(:stdout) { should match /Process 'mysql-proxy'/ }
  end

  describe file('/etc/mysql-proxy/config') do
    its(:content) { should match 'proxy-backend-addresses=127.0.0.1:3306,127.0.0.2:3306' }
    its(:content) { should match 'plugins=proxy' }
  end

  describe port(4040) do
    it { should be_listening }
  end

  describe command('mysql --host=127.0.0.1 --port=4040 -e "SHOW DATABASES;"') do
    its(:stdout) { should match /example_db/ }
  end

  describe command('mysql --host=localhost --port=4040 -e "SHOW DATABASES;"') do
    its(:stdout) { should match /example_db/ }
  end

  describe command('mysql-proxy --version') do
    its(:exit_status) { should eq 0 }
  end
end
