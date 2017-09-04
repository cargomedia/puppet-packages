require 'spec_helper'

describe 'systemd::critical_units' do

  describe file('/etc/systemd/system/critical-units.target') do
    it { should be_file }
  end

  describe command('systemctl list-dependencies --plain critical-units.target | grep stopped.service') do
    its(:exit_status) { should eq 0 }
  end

  describe command('systemctl list-dependencies --plain critical-units.target | grep failed.service') do
    its(:exit_status) { should eq 0 }
  end

  describe command('systemctl is-active critical-units.target') do
    its(:exit_status) { should eq 0 }
  end

  describe service('critical-units-check') do
    it { should be_enabled }
    it { should be_running }
  end

  describe command('journalctl -u critical-units-check --no-pager') do
    its(:stdout) { should match /Critical unit failed: failed\.service/ }
    its(:stdout) { should match /Critical unit stopped: stopped\.service/ }
  end

end
