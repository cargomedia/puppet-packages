require 'spec_helper'

describe 'mongodb::mongod' do

  describe command('echo "db.test_collection.insert({\'boo\':\'good-pass\'});" | mongo testdb -u "basicuser" -p "my-password" --host localhost --port 27017') do
    its(:exit_status) { should eq 0 }
  end

  describe command('echo "db.test_collection.insert({\'boo\':\'bad-pass\'});" | mongo testdb -u "basicuser" -p "bad-passwd" --host localhost --port 27017') do
    its(:exit_status) { should eq 1 }
  end
end
