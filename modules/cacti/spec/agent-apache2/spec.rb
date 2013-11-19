require 'spec_helper'

describe package('apache2') do
  it { should be_installed }
end

describe package('php5-common') do
  it { should be_installed }
end

describe command('curl http://localhost/apc-status') do
  its(:stdout) { should match // }
end

describe command('curl http://localhost/anypage') do
  its(:stdout) { should match /not found/ }
end