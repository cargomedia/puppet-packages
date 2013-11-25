require 'spec_helper'

describe package('lvm2') do
  it {should be_installed }
end

describe command('which pvcreate') do
  it { should return_exit_status 0 }
end

describe command('which vgcreate') do
  it { should return_exit_status 0 }
end

describe command('which lvcreate') do
  it { should return_exit_status 0 }
end

describe command('which arcconf') do
  it { should return_exit_status 0 }
end

describe file('/root/bin/expand-raid.sh') do
  it { should be_file }
end

describe package('xfsprogs') do
  it {should be_installed }
end

describe command('which xfs_growfs') do
  it { should return_exit_status 0 }
end

describe file('/root/bin/expand-raid.sh') do
  it {should be_file }
end