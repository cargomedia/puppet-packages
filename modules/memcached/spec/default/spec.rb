require 'spec_helper'

describe 'memcached' do

  describe port(11211) do
    it { should be_listening }
  end

  describe file('/etc/memcached.conf') do
    it { should contain '-c 99' }
  end
end
