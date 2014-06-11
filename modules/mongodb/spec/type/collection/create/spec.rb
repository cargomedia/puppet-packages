require 'spec_helper'

describe command('mongo testdb --quiet --host localhost --port 27017 --eval "db.getCollectionNames()"') do
  its(:stdout) { should match /mycollection/ }
end
