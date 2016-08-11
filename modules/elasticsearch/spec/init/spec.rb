require 'spec_helper'

describe 'elasticsearch' do

  describe package('elasticsearch') do
    it { should be_installed }
  end

  describe file('/etc/elasticsearch/elasticsearch.yml') do
    its(:content) { should match 'network.publish_host: localhost' }
    its(:content) { should match 'cluster.name: foo' }
  end

  describe process('elasticsearch') do
    its(:count) { should eq 1 }
  end

  describe command('ps aux | grep elasticsearch') do
    its(:stdout) { should match 'java -Xms123m -Xmx123m' }
  end
end
