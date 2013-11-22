require 'spec_helper'

describe package('mysql-proxy') do
  it { should be_installed }
end

describe command('monit summary') do
  its(:stdout) { should match /Process 'mysql-proxy'/ }
end
