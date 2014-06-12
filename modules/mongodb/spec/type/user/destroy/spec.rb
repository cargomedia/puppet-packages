require 'spec_helper'

describe command('mongo testdb --quiet --host localhost --port 27017 --eval "printjson(null == db.getUser(\"testuser\"))"') do
  its(:"stdout") { should match 'true' }
end
