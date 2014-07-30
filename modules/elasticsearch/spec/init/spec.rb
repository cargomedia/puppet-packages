require 'spec_helper'

describe package('elasticsearch') do
  it { should be_installed }
end

describe file('/etc/elasticsearch/elasticsearch.yml') do
  its(:content) { should match 'network.publish_host: localhost' }
  its(:content) { should match 'cluster.name: foo' }
end

describe command('pgrep java | wc -l') do
  its(:stdout) { should match /^1$/ }
end

describe command('ps aux | grep elasticsearch') do
  its(:stdout) { should match 'java -Xms123m -Xmx123m' }
end
