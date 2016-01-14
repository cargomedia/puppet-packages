require 'spec_helper'

describe 'daemon' do

  describe service('my-program') do
    it { should be_enabled }
    it { should be_running }
  end

# With *sysvinit* we check monit for process
  check_initv = "monit summary | grep -qE 'Process+.+my-program'"

# With *systemd* we check monit for program
  check_systemd = "monit summary | grep -qE 'Program+.+my-program+.+ok'"

  describe command("if (test -e /bin/systemctl); then #{check_systemd}; else #{check_initv}; fi") do
    its(:exit_status) { should eq 0 }
  end

# With *sysvinit* we don't test anything
  check_initv = "echo ok"

# With *systemd* we check that monit has alerted
  check_systemd = "journalctl -u monit --no-pager | grep -qE 'my-program+.+\/bin\/systemctl+.+failed'"

  describe command("if (test -e /bin/systemctl); then #{check_systemd}; else #{check_initv}; fi") do
    its(:exit_status) { should eq 0 }
  end
end
