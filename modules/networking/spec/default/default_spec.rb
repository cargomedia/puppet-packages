require 'spec_helper'

describe file('/etc/network/interfaces') do
  it { should be_file }
  it { should contain 'foo' }
end

# Needs to pass domain fact to make it work
describe host('foobar') do
  it { should be_resolvable }
end