require 'spec_helper'

describe 'raid::hpssacli' do

  describe package('hpssacli') do
    it { should be_installed }
  end

  describe command('hpssacli version') do
    its(:exit_status) { should eq 0 }
  end

  describe command('monit summary') do
    its(:stdout) { should match /Program 'raid-hpssacli'/ }
  end
end
