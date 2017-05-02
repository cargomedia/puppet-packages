require 'spec_helper'

describe 'elasticsearch' do

  describe package('elasticsearch') do
    it { should be_installed }
  end

  describe process('java') do
    its(:count) { should eq 1 }
  end

  describe command('ps aux | grep elasticsearch') do
    its(:stdout) { should match 'java -Xms123m -Xmx123m' }
  end

  describe file('/var/log/elasticsearch/foo.log') do
    it { should be_file }
    its(:content) { should match /starting \.\.\./ }
    its(:content) { should match /started/ }
  end

  describe command('curl localhost:9200/_nodes/_local') do
    its(:stdout) { should match /\{"cluster_name":"foo",/}
    its(:stdout) { should match /,"node":\{"local":"true"\},/}
    its(:stdout) { should match /"publish_address":"inet\[localhost\/127\.0\.0\.1:9200\]/}
  end
end
