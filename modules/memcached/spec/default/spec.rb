require 'spec_helper'

describe port(11211) do
  it { should be_listening }
end

['/etc/monit/conf.d/memcached', '/etc/bipbip/services.d/memcached.yml'].each do |file|
  describe file(file) do
    it { should be_file }
  end
end

describe file('/etc/memcached.conf') do
  it { should contain '-c 99' }
  it { should contain '-vvv' }
end

describe command('ruby -e \'require "date";p Date.parse(File.open("/var/log/memcached.log").first)\'') do
  it { should return_exit_status 0 }
end
