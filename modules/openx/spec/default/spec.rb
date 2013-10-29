require 'spec_helper'

describe port(80) do
  it { should be_listening }
end

describe port(443) do
  it { should be_listening }
end

describe command('curl http://localhost -L') do
  its(:stdout) { should match 'OpenX' }
end

describe command('curl https://localhost -Lk') do
  its(:stdout) { should match 'OpenX' }
end
