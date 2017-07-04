require 'spec_helper'

describe 'mysql::slave' do

  describe file ('/etc/bipbip/services.d/is-replication-running.yml') do
    its(:content) { should match /mysql-replication-check root foofoo/}
  end

  describe command('/usr/local/bin/mysql-replication-check root foofoo') do
    its(:stdout) { should match /\{"mysql slave replication failure": "true"\}/ }
  end

  describe command('QUERY_RESULT_SPEC="foo bar Slave_running   ON" /usr/local/bin/mysql-replication-check root foofoo') do
    its(:stdout) { should match /\{"mysql slave replication failure": "false"\}/ }
  end
end
