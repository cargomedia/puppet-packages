require 'spec_helper'

describe 'raid::adaptec' do

  describe package('arcconf') do
    it { should be_installed }
  end

  describe command('arcconf getversion') do
    its(:exit_status) { should eq 0 }
  end

  describe command('sudo -u bipbip sudo raid-adaptec') do
    its(:exit_status) { should eq 0 }
  end

  describe service('bipbip') do
    it { should be_running }
  end

  describe command('journalctl -u bipbip --no-pager') do
    its(:stdout) { should match(/raid::.+raid_adaptec.+Data: {:status=>1}/) }
  end

end
