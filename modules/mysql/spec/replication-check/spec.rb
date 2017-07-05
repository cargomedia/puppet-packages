require 'spec_helper'

describe 'mysql::slave' do

  describe file ('/etc/bipbip/services.d/is-replication-running.yml') do
    its(:content) {should match /mysql-replication-check bipbip/}
  end

  describe command('mysql --user=bipbip --execute=\'show global status like "Slave_running"\G;\'') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /Variable_name:.+Slave_running/}
    its(:stdout) { should match /Value:.+OFF/}
  end

  describe command('/usr/local/bin/mysql-replication-check') do
    its(:stdout) {should match /\{"mysql slave replication failure": true\}/}
  end

end
