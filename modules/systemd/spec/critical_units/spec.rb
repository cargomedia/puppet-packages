require 'spec_helper'

describe 'systemd::critical_units' do

  describe file('/etc/systemd/system/critical-units.target') do
    it { should be_file }
  end

  describe file('/etc/systemd/system/critical-units.target.wants/my-daemon.service') do
    it { should be_symlink }
  end

  describe command('systemctl list-dependencies --plain critical-units.target | grep my-daemon.service') do
    its(:exit_status) { should eq 0 }
  end
end
