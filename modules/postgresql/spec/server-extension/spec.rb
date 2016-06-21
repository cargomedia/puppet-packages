require 'spec_helper'

describe 'postgresql::server::extension' do

  describe command('sudo -u postgres psql "my-db" -t -c "SELECT extname FROM pg_extension;"') do
    its(:stdout) { should match 'pg_trgm' }
  end

end
