require 'spec_helper'

describe 'cm::application' do

  describe command('if (which systemctl > /dev/null); then test -f /etc/systemd/system/critical-units.target.d/wants-cm-applications.target.conf; fi') do
    its(:exit_status) { should eq 0 }
  end
end
