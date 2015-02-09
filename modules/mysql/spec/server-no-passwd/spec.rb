require 'spec_helper'

describe command('/etc/init.d/mysql status') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match 'Uptime' }
end

describe command('mysql -e "show status"') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match 'Uptime' }
end
