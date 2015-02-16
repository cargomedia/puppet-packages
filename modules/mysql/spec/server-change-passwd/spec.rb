require 'spec_helper'

describe 'mysql::server change password' do

  describe command('/etc/init.d/mysql status') do
    its(:exit_status) { should eq 0 }
  end
end
