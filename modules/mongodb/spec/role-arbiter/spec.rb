require 'spec_helper'

describe 'mongodb::role::arbiter' do

  describe command('mongo --quiet --host localhost --port 27003 --eval "printjson(db.isMaster())"') do
    its(:stdout) { should match /"arbiterOnly" : true/ }
  end
end
