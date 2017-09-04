require 'spec_helper'

describe 'systemd::critical_units' do

  describe file('/etc/systemd/system/critical-units.target') do
    it { should be_file }
  end

  describe command('systemctl list-dependencies --plain critical-units.target | grep foo.service') do
    its(:exit_status) { should eq 0 }
  end

  describe command('systemctl list-dependencies --plain critical-units.target | grep bar.service') do
    its(:exit_status) { should eq 0 }
  end

  describe command('systemctl is-active critical-units.target') do
    its(:exit_status) { should eq 0 }
  end

  describe service('critical-units-check') do
    it { should be_enabled }
    it { should be_running }
  end

  describe command('timeout --signal=9 30 bash -c "while ! (systemctl is-failed bar.service); do sleep 0.1; done"') do
    its(:exit_status) { should eq 0 }
  end

  describe command('systemctl restart critical-units-check && sleep 0.1') do
    its(:exit_status) { should eq 0 }
  end

  describe command('journalctl -u critical-units-check --no-pager') do
    its(:stdout) { should match /Critical unit stopped: foo\.service/ }
    its(:stdout) { should match /Critical unit failed: bar\.service/ }
  end

end
