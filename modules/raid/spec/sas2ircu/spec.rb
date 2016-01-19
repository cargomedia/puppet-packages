require 'spec_helper'

describe 'raid::sas2ircu' do

  describe package('sas2ircu') do
    it { should be_installed }
  end

  describe command('sas2ircu-status') do
    its(:exit_status) { should eq 0 }
  end

  describe command('monit summary') do
    its(:stdout) { should match /Program 'raid-sas'/ }
  end
end
