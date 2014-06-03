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

describe port(27017) do
  it { should be_listening.with('tcp') }
end

# add data
describe command('echo "db.test_db.insert({\'test\':\'now\'});" | mongo --host localhost --port 27017') do
  it { should return_exit_status 0 }
end

# get status
describe command('echo "sh.status();" | mongo --host localhost --port 27017') do
  its(:stdout) { should match /"host" : "localhost:27000"/ }
  its(:stdout) { should match /"host" : "localhost:27001"/ }
  its(:stdout) { should match /"testdb"/ }
end
