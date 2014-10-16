require 'spec_helper'

describe port(11211) do
  it { should be_listening }
end

describe command('monit summary') do
  its(:stdout) { should match /memcached/ }
end
