require 'spec_helper'

describe 'lvm' do

  describe package('lvm2') do
    it { should be_installed }
  end

  describe command('which pvcreate') do
    its(:exit_status) { should eq 0 }
  end

  describe command('which vgcreate') do
    its(:exit_status) { should eq 0 }
  end

  describe command('which lvcreate') do
    its(:exit_status) { should eq 0 }
  end

  describe command('which arcconf') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/root/bin/expand-raid.sh') do
    it { should be_file }
  end

  describe package('xfsprogs') do
    it { should be_installed }
  end

  describe command('which xfs_growfs') do
    its(:exit_status) { should eq 0 }
  end
end
