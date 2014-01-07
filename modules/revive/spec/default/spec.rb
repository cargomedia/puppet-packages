require 'spec_helper'

describe port(80) do
  it { should be_listening }
end

describe port(443) do
  it { should be_listening }
end

describe command('env no_proxy=example.com curl http://example -L') do
  its(:stdout) { should match 'Revive Adserver' }
end

describe command('curl https://example.com -Lk') do
  its(:stdout) { should match 'Revive Adserver' }
end
