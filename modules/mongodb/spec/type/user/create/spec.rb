require 'spec_helper'

describe 'mongodb_user create' do

  describe command('mongo testdb --host localhost --port 27017 --username testuser --password my-password2 --eval "db.getMongo()"') do
    its(:exit_status) { should eq 0 }
  end

  describe command('mongo admin --host localhost --port 27017 --username testuser --password my-password2 --eval "db.getMongo()"') do
    its(:exit_status) { should eq 0 }
  end

  describe command('mongo testdb --host localhost --port 27017 --username testuser --password not-my-password --eval "db.getMongo()"') do
    its(:exit_status) { should eq 1 }
    its(:stdout) { should match /auth failed/ }
  end

end
