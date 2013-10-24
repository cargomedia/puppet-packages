require 'spec_helper'

describe file('/etc/network/interfaces') do
  it { should be_file }
  it { should contain 'foo' }
end

describe host('foo') do
  it { should be_resolvable }
end
