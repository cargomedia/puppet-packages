require 'spec_helper'

describe 'daemon' do

  describe service('my-program') do
    it { should be_enabled }
    it { should be_running }
  end

# With *sysvinit* we only check monit and for a different output
  check_initv = "monit summary | grep -E \"Process 'my-program'\"",

# With *systemd* we check monit and that it has given an alert
  check_systemd = [
          "monit summary | grep -E \"Program 'my-program'\"",
          "journalctl -u monit --no-pager | grep -E \"'my-program' '\/bin\/systemctl' failed with exit status \(3\)\"",
      ].join(' && ')

  describe command("if (test -e /bin/systemctl); then #{check_systemd}; else #{check_initv}; fi") do
    its(:exit_status) { should eq 0 }
  end
end
