require 'spec_helper'

describe 'postgresql::server::database' do

  describe command('sudo -u postgres psql -t -c "SELECT datname FROM pg_database;"') do
    its(:stdout) { should match 'foo' }
    its(:stdout) { should match 'bar' }
  end

end
