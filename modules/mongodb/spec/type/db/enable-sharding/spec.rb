require 'spec_helper'

describe command('mongo --quiet --host localhost --port 27017 --eval "db.printShardingStatus()"') do
  its(:stdout) { should match /"_id" : "testdb",  "partitioned" : true/ }
end

