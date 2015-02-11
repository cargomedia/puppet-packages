require 'spec_helper'

describe 'mongodb_database create' do

  describe command('mongo --quiet --host localhost --port 27017 --eval "printjson(db.getMongo().getDB(\'testdb\').stats())"') do
    its(:stdout) { should match /"db" : "testdb"/ }
  end
end
