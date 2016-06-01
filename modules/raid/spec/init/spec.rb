require 'spec_helper'

describe 'raid' do

  describe package('arcconf') do
    it { should be_installed }
  end

  describe command('arcconf getversion') do
    its(:exit_status) { should eq 0 }
  end

  describe command('aacraid-status') do
    its(:exit_status) { should eq 0 }
  end

  describe command('monit summary') do
    its(:stdout) { should match /Program 'raid-adaptec'/ }
  end

  describe package('sas2ircu') do
    it { should be_installed }
  end

  describe package('mdadm') do
    it { should be_installed }
  end

  describe command('monit summary') do
    its(:stdout) { should match /Program 'raid-sas'/ }
  end

end
