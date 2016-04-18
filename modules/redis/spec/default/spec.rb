require 'spec_helper'

describe 'redis' do

  describe command('netstat -atlpn') {
    its(:stdout) { should match /0\.0\.0\.0:6379+.+redis-server/ }
  }

  describe command('monit summary') do
    its(:exit_status) { should eq 0 }
  end
end
