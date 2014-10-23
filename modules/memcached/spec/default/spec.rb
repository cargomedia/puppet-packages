require 'spec_helper'

describe port(11211) do
  it { should be_listening }
end

describe command('monit summary') do
  its(:stdout) { should match /memcached/ }
end

describe file('/etc/memcached.conf') do
  it { should contain '-c 99' }
end

describe command('>/var/log/memcached.log && monit restart memcached')

describe command('ruby -e \'require "date";p Date.parse(File.open("/var/log/memcached.log").first)\'') do
  it { should return_exit_status 0 }
end
