require 'spec_helper'

describe package('mysql-proxy') do
  it { should be_installed }
end

describe command('monit summary') do
  its(:stdout) { should match /Process 'mysql-proxy'/ }
end

describe file('/etc/default/mysql-proxy') do
  its(:content) { should match '--proxy-backend-addresses=10.10.10.12:3306' }
  its(:content) { should match '--proxy-backend-addresses=10.10.10.13:3306' }
end
