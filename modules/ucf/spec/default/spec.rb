require 'spec_helper'

describe 'ucf::default' do

  describe package('ucf') do
    it { should be_installed }
  end

  describe file('/etc/ucf.conf') do
    it { should be_file }
    its(:content) { should match /conf_force_conffold=YES/ }
  end
end
