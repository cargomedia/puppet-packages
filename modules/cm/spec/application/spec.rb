require 'spec_helper'

describe 'cm::application' do

  describe command('if (which systemctl > /dev/null); then test -h /etc/systemd/system/critical-units.target.wants/cm-applications.target; fi') do
    its(:exit_status) { should eq 0 }
  end
end
