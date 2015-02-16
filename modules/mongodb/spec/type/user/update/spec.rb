require 'spec_helper'

describe 'mongodb_user update' do

  describe command('mongo testdb --host localhost --port 27017 --username testuser --password my-password3 --eval "db.getMongo()"') do
    its(:exit_status) { should eq 0 }
  end

  describe command('mongo testdb --host localhost --port 27017 --eval "printjson(db.getUser(\"testuser\"))"') do
    its(:"stdout") { should match /"role" : "read"/ }
  end
end
