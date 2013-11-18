require 'spec_helper'

describe port(80) do
  it { should be_listening }
end

describe port(443) do
  it { should be_listening }
end

describe command('curl http://example.com -L') do
  its(:stdout) { should match 'OpenX' }
end

describe command('curl https://example.com -Lk') do
  its(:stdout) { should match 'OpenX' }
end
