require "spec_helper"


describe 'mongodb::role::shard::without-replset' do

  describe port(27018) do
    it { should be_listening.with('tcp') }
  end

  describe command('mongo --host localhost --port 27017 --eval "sh.status()"') do
    its(:stdout) { should match /"host" : "localhost:27018"/ }
  end
end
