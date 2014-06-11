require 'spec_helper'

describe command('mongo testdb --quiet --host localhost --port 27017 --eval "null == db.getUser(\"testuser\")"') do
  its(:"stdout") { should equals 'true' }
end
