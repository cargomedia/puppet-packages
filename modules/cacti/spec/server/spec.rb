require 'spec_helper'

describe package('cacti') do
  it { should be_installed }
end

describe package('mysql-server') do
  it { should be_installed }
end

describe package('apache2') do
  it { should be_installed }
end

describe package('php5-common') do
  it { should be_installed }
end