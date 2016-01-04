require 'spec_helper'

describe 'lightdm::config::display_always_on' do

  describe command('XAUTHORITY=/var/run/lightdm/root/:0 DISPLAY=:0 xset -q') do
    its(:stdout) { should match('DPMS is Disabled') }
    its(:stdout) { should contain('timeout:  0').after('Screen Saver:') }
  end

end
