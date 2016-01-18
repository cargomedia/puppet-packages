require 'spec_helper'

describe 'raid::lsi_megaraidsas' do

  describe command('monit summary') do
    its(:stdout) { should match /Program 'raid-lsi'/ }
  end

  describe command('lsi-raid-status') do
    its(:exit_status) { should eq 0 }
  end
end
