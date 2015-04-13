require 'spec_helper'

describe 'cm::services' do

  describe package('redis-server') do
    it { should be_installed }
  end

  describe package('mysql-server') do
    it { should be_installed }
  end

  describe package('memcached') do
    it { should be_installed }
  end

  describe package('elasticsearch') do
    it { should be_installed }
  end

  describe package('memcached') do
    it { should be_installed }
  end

  describe package('gearman-job-server') do
    it { should be_installed }
  end

  describe package('memcached') do
    it { should be_installed }
  end

  describe package('mongodb-org-server') do
    it { should be_installed }
  end

  describe package('nginx') do
    it { should be_installed }
  end

end
