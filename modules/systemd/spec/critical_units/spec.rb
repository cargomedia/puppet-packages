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
end
