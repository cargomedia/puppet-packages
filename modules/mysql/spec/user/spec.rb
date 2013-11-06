require 'spec_helper'

describe command('mysql -u root --execute "select User from mysql.user;"') do
  its(:stdout) { should match 'foo' }
end
