require 'spec_helper'

describe 'raid::lsi_megaraidsas' do

  describe package('storcli') do
    it { should be_installed }
  end

  describe command('monit summary') do
    its(:stdout) { should match /Program 'raid-lsi'/ }
  end

  describe command('megaraidsas-status') do
    its(:exit_status) { should eq 0 }
  end
end
