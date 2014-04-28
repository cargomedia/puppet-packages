require 'spec_helper'

describe file('/tmp/source/foo') do
  it { should be_file }
end

describe service('nfs-common') do
  it { should be_enabled }
  it { should be_running }
end

describe service('nfs-kernel-server') do
  it { should be_enabled }
  it { should be_running }
end

describe command('monit summary | grep nfs-server') do
  it { should return_exit_status 0 }
end

describe command('ps ax | grep "\[nfsd\]" | wc -l') do
  it { should return_exit_status 0 }
  its(:stdout) { should match /32/ }
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
  it { should be_mode 703 }
  it { should be_owned_by 'nobody' }
  it { should be_grouped_into 'nogroup' }
  it { should be_mounted }
end

describe file('/tmp/mounted/bar') do
  it { should be_file }
end

describe file('/nfsexport/shared') do
  it { should be_directory }
  it { should be_mode 703 }
  it { should be_owned_by 'nobody' }
  it { should be_grouped_into 'nogroup' }
end
