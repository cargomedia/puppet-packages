require 'spec_helper'

describe 'memcached' do

  describe port(11211) do
    it { should be_listening }
  end

  describe command('monit summary') do
    its(:stdout) { should match /memcached/ }
  end

  describe file('/etc/memcached.conf') do
    it { should contain '-c 99' }
  end
end
