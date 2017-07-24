require 'spec_helper'

describe 'raid::linux_md' do

  describe package('mdadm') do
    it { should be_installed }
  end

  describe file('/etc/mdadm/mdadm.conf') do
    it { should be_file }
  end

  describe file('/proc/mdstat') do
    it { should be_readable }
  end

  describe service('bipbip') do
    it { should be_running }
  end
end
