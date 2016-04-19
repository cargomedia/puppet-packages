require 'spec_helper'

describe 'redis' do

  describe command('netstat -atlpn') do
    its(:stdout) { should match /0\.0\.0\.0:6379+.+redis-server/ }
  end
end
