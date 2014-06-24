require 'spec_helper'

describe command('mongo testdb --host localhost --port 27017 --username testuser --password my-password3 --eval "db.getMongo()"') do
  it { should return_exit_status 0 }
end

describe command('mongo testdb --host localhost --port 27017 --eval "printjson(db.getUser(\"testuser\"))"') do
  its(:"stdout") { should match /"role" : "read"/ }
end
