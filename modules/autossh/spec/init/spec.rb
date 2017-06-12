require 'spec_helper'

describe 'autossh' do

  describe package('autossh') do
    it { should be_installed }
  end

  describe service('autossh-nc-forwarding') do
    it { should be_enabled }
    it { should be_running }
  end

  describe command('netstat -tupln') do
    its(:stdout) { should match /127.0.0.1:8000 .+\/nc/ }
    its(:stdout) { should match /127.1.1.1:8001 .+\/nc/ }
    its(:stdout) { should match /127.0.0.1:9000 .+\/sshd/ }
    its(:stdout) { should match /127.0.0.1:9001 .+\/sshd/ }
  end

  describe command('nc 127.0.0.1 9000') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /nc1/ }
  end

  describe command('nc 127.0.0.1 9001') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /nc2/ }
  end

end
