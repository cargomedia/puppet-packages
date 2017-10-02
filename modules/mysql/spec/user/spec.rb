require 'spec_helper'

describe 'mysql::user' do

  describe command('mysql -u root --execute "select User from mysql.user;"') do
    its(:stdout) {should match 'foo'}
    its(:stdout) {should match 'bar'}
  end

  describe "Mysql must not execute without a password" do
    describe command('mysql -u bar -e \'show databases\'') do
      its(:exit_status) {should eq 1}
    end
  end
end
