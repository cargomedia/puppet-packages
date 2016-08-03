require 'spec_helper'

describe 'mysql::server no password' do

  describe command('mysql -e "show status"') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match 'Uptime' }
  end

  describe file('/etc/logrotate.d/mysql-server-error') do
    it 'is a file' do
      expect(subject).to be_file
    end
  end
end
