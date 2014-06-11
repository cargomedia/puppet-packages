require 'spec_helper'

describe command('mongo testdb --host localhost --port 27017 --username testuser --password my-password2 --eval "db.getMongo()"') do
  it { should return_exit_status 0 }
end

describe command('mongo testdb --host localhost --port 27017 --username testuser --password not-my-password --eval "db.getMongo()"') do
  it { should return_exit_status 1 }
  its(:stdout) { should match /auth failed/ }
end

describe command('mongo admin --host localhost --port 27017 --username testuser --password my-password2 --eval "db.getMongo()"') do
  it { should return_exit_status 1 }
  its(:stdout) { should match /auth failed/ }
end
