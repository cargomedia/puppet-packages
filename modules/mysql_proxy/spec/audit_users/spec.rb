require 'spec_helper'

describe 'mysql_proxy' do

  describe package('mysql-proxy') do
    it { should be_installed }
  end

  describe port(4040) do
    it { should be_listening }
  end

  describe file('/etc/mysql-proxy/script.lua') do
    its(:content) { should match 'foo' }
    its(:content) { should_not match 'bar' }
  end

  describe command('mysql -N -B --user=foo --password=pass --host=127.0.0.1 --port=4040 -e "SELECT 1234" && journalctl -n 1 -u mysql-proxy.service') do
    its(:stdout) { should match /^1234$/ }
    its(:stdout) { should match /\[foo\] query: SELECT 1234$/ }
  end

  describe command('mysql -N -B --user=bar --password=pass --host=127.0.0.1 --port=4040 -e "SELECT 5678" && journalctl -n 1 -u mysql-proxy.service') do
    its(:stdout) { should match /^5678$/ }
    its(:stdout) { should_not match /SELECT 5678/ }
  end
end
