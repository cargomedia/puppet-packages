require 'spec_helper'

describe package('mysql-server') do
  it { should be_installed }
end

describe command("mysql -e 'select user from mysql.user'") do
  its(:stdout) { should match /sense-cacti/ }
end