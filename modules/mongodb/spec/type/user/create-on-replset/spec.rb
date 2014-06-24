require 'spec_helper'

describe command('mongo testdb --host localhost --port 27001 --username testuser --password my-password2 --eval "db.getMongo()"') do
  it { should return_exit_status 0 }
end

describe command('mongo testdb --host localhost --port 27002 --username testuser --password my-password2 --eval "db.getMongo()"') do
  it { should return_exit_status 0 }
end
