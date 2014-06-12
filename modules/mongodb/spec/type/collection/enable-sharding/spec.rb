require 'spec_helper'

describe command('mongo testdb --quiet --host localhost --port 27017 --eval "printjson(db.getCollection(\'mycollection\').stats())"') do
  its(:stdout) { should match /"sharded" : true/ }
end

