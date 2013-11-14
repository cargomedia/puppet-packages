require 'spec_helper'

describe file('/etc/nginx/nginx.conf') do
  it { should be_file }
end

describe file('/etc/nginx/conf.d/proxy.conf') do
  it { should be_file }
end

describe file('/etc/nginx/conf.d/backend-socketredis-upstream.conf') do
  it { should be_file }
end

describe file('/etc/nginx/conf.d/vhost_autogen.conf') do
  it { should be_file }
end

describe command('monit summary | grep nginx') do
  it { should return_exit_status 0 }
end

describe port(8090) do
  it { should be_listening }
end

describe command('openssl s_client -connect localhost:8090 | grep "CONNECTED"') do
  it { should return_exit_status 0 }
end