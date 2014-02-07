require 'spec_helper'

describe file('/tmp/source/foo') do
  it { should be_file }
end

describe command('monit summary | grep nfs-server') do
  it { should return_exit_status 0 }
end

describe file('/tmp/source/bar') do
  it { should be_file }
end

describe file('/nfsexport/shared/foo') do
  it { should be_file }
end

describe file('/nfsexport/shared/bar') do
  it { should be_file }
end

describe file('/tmp/mounted') do
  it { should be_directory }
  it { should be_mode 607 }
  it { should be_owned_by 'nobody' }
  it { should be_grouped_into 'nogroup' }
end

describe file('/tmp/mounted/bar') do
  it { should be_file }
end

describe file('/nfsexport/shared') do
  it { should be_directory }
  it { should be_mode 607 }
  it { should be_owned_by 'nobody' }
  it { should be_grouped_into 'nogroup' }
end
