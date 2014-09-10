require 'spec_helper'

describe command('mysql -u root --execute "select User from mysql.user;"') do
  its(:stdout) { should match 'foo' }
end

describe command('mysql -u root -Be "SHOW GRANTS FOR foo@localhost;"') do
  its(:stdout) { should match "GRANT SELECT ON `bar`.* TO 'foo'@'localhost'" }
end
