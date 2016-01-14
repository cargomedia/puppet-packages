require 'spec_helper'

describe 'raid::sas2ircu' do

  describe package('sas2ircu') do
    it { should be_installed }
  end

  describe command('monit summary') do
    its(:stdout) { should match /Program 'raid-sas'/ }
  end
end
