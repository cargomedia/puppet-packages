require 'spec_helper'

describe 'mysql::server change password' do

  describe command('mysql -e "show status"') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match('Uptime') }
  end
end
