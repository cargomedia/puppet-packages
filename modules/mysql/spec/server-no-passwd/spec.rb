require 'spec_helper'

describe command('/etc/init.d/mysql status') do
  it { should return_exit_status 0 }
  its(:stdout) { should match 'Uptime' }
end

describe command('mysql -e "show status"') do
  it { should return_exit_status 0 }
  its(:stdout) { should match 'Uptime' }
end
