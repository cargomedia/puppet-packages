require 'spec_helper'

describe 'postgresql::server::role' do

  describe command('sudo -u postgres psql -t -c "SELECT rolname FROM pg_roles;"') do
    its(:stdout) { should match 'foo' }
    its(:stdout) { should match 'bar' }
  end

end
