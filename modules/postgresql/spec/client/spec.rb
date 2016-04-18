require 'spec_helper'

describe 'postgresql::client' do

  describe command('psql --version') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match('9.4.') }
  end

end
