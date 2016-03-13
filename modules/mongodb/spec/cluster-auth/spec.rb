require 'spec_helper'

describe 'mongodb::cluster' do

# add data
  describe command('echo "db.test_collection.insert({\'foo\':\'foo\'});" | mongo testdb --host localhost --port 27017') do
    its(:exit_status) { should eq 0 }
  end

# get sharding status
  describe command('echo "sh.status();" | mongo --host localhost --port 27017') do
    its(:stdout) { should match /"host" : "rep1\/localhost:27001,localhost:27002"/ }
    its(:stdout) { should match /"host" : "rep2\/localhost:27006,localhost:27007"/ }
    its(:stdout) { should match /"testdb",  "partitioned" : true,  "primary" : "rep[1-2]"/ }
  end
end
