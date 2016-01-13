require 'spec_helper'

describe 'raid::adaptec' do

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
end
