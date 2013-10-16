require 'spec_helper'

describe command('touch /tmp/foo') do
  it { should return_exit_status 0 }
end

describe file('/nfsexport/shared/foo') do
  it { should be_file }
end
