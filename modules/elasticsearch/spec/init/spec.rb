require 'spec_helper'

describe package('elasticsearch') do
  it { should be_installed }
end

describe file('/etc/default/elasticsearch') do
  its(:content) { should match 'ES_HEAP_SIZE=512m' }
end

describe file('/etc/elasticsearch/elasticsearch.yml') do
  its(:content) { should match 'network.publish_host: localhost' }
  its(:content) { should match 'cluster.name: foo' }
end
