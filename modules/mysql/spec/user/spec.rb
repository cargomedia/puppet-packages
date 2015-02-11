require 'spec_helper'

describe 'mysql::user' do

  describe command('mysql -u root --execute "select User from mysql.user;"') do
    its(:stdout) { should match 'foo' }
    its(:stdout) { should match 'bar' }
  end
end
