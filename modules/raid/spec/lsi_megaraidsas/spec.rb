require 'spec_helper'

describe 'raid::lsi_megaraidsas' do

  describe package('storcli') do
    it { should be_installed }
  end

  describe command('megaraidsas-status') do
    its(:exit_status) { should eq 0 }
  end

  describe service('bipbip') do
    it { should be_running }
  end
end
