require 'spec_helper'

describe file('/etc/init.d/foo') do
  it { should be_file }
  it { should be_executable }
end

describe service('foo') do
  it { should be_running }
  it { should be_enabled.with_level(3) }
  it { should_not be_enabled.with_level(6) }
end
