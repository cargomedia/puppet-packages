require 'spec_helper'

describe file('/etc/nginx/nginx.conf') do
  it { should be_file }
end

describe port(80) do
  it { should be_listening }
end