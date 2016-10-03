require 'spec_helper'

describe 'memcached' do

  describe port(11211) do
    it { should be_listening }
  end

  describe process('memcached') do
    its(:count) { should eq 1 }
    its(:user) { should eq 'memcache' }
    its(:args) { should match /-c 99\b/ }
  end
end
