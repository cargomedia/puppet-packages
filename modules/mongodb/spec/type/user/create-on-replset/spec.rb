require 'spec_helper'

describe 'mongodb_user create on replset' do

  describe command('mongo testdb --host localhost --port 27001 --username testuser --password my-password2 --eval "db.getMongo()"') do
    its(:exit_status) { should eq 0 }
  end

  describe command('mongo testdb --host localhost --port 27002 --username testuser --password my-password2 --eval "db.getMongo()"') do
    its(:exit_status) { should eq 0 }
  end
end
