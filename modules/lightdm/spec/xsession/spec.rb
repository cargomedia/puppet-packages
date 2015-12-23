require 'spec_helper'

describe 'lightdm::xsession' do

  describe package('lightdm') do
    it { should be_installed }
  end

  describe file('/usr/share/xsessions/my-session.desktop') do
    its(:content) { should match('Exec=/bin/true') }
  end

end
