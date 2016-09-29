require 'spec_helper'

describe 'daemon' do

  # With *systemd* we KILL the whole process cgroup if the process doesn't respond to TERM
  check_systemd = [
    '! pgrep -f "^/bin/bash /tmp/my-program$"',
    '! pgrep -f "^/bin/bash /tmp/my-program-child$"',
    'systemctl status my-program | grep -q "Active: failed (Result: signal)"',
  ].join(' && ')

  describe command("#{check_systemd}") do
    its(:exit_status) { should eq 0 }
  end

end
