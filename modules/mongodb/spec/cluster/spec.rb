require 'spec_helper'

describe port(28000) do
  it { should be_listening.with('tcp') }
end

describe port(28001) do
  it { should be_listening.with('tcp') }
end

describe port(28002) do
  it { should be_listening.with('tcp') }
end

describe port(27000) do
  it { should be_listening.with('tcp') }
end

describe port(27001) do
  it { should be_listening.with('tcp') }
end

describe port(27002) do
  it { should be_listening.with('tcp') }
end

describe port(27005) do
  it { should be_listening.with('tcp') }
end

describe port(27006) do
  it { should be_listening.with('tcp') }
end

describe port(27007) do
  it { should be_listening.with('tcp') }
end

describe port(27017) do
  it { should be_listening.with('tcp') }
end

# add data
describe command('echo "db.test_collection.insert({\'foo\':\'foo\'});" | mongo testdb --host localhost --port 27017') do
  it { should return_exit_status 0 }
end

describe command('echo "db.test_collection.insert({\'boo\':\'boo\'});" | mongo dummydb --host localhost --port 27017') do
  it { should return_exit_status 0 }
end

# get sharding status
describe command('echo "sh.status();" | mongo --host localhost --port 27017') do
  its(:stdout) { should match /"host" : "rep1\/localhost:27001,localhost:27002"/ }
  its(:stdout) { should match /"host" : "rep2\/localhost:27006,localhost:27007"/ }
  its(:stdout) { should match /"testdb",  "partitioned" : true,  "primary" : "rep[1-2]"/ }
  its(:stdout) { should match /"dummydb",  "partitioned" : true,  "primary" : "rep[1-2]"/ }
end

# get rep1 status
describe command('mongo --host localhost --port 27001 --eval \'printjson(rs.status())\'') do
  its(:stdout) { should match /"set" : "rep1"/ }
  its(:stdout) { should match /"ARBITER"/ }
  its(:stdout) { should match /"PRIMARY"/ }
  its(:stdout) { should match /"SECONDARY"/ }
end

# get rep2 status
describe command('mongo --host localhost --port 27006 --eval \'printjson(rs.status())\'') do
  its(:stdout) { should match /"set" : "rep2"/ }
  its(:stdout) { should match /"ARBITER"/ }
  its(:stdout) { should match /"PRIMARY"/ }
  its(:stdout) { should match /"SECONDARY"/ }
end
