require 'spec_helper'

describe 'elasticsearch' do

  # Wait for elasticsearch to start up
  describe command('timeout --signal=9 30 bash -c "while ! (curl -s http://localhost:9200/); do sleep 0.5; done"') do
    its(:exit_status) { should eq 0 }
  end

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
    its(:stdout) { should match '"cluster_name":"foo"'}
    its(:stdout) { should match '"transport":{"type":"local"}'}
    its(:stdout) { should match '"publish_address":"127.0.0.1:9200"'}
  end

  describe command('sudo netstat -anlp') do
    its(:stdout) { should match ' :::9200 .+/java' }
  end
end
