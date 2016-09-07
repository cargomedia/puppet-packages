require 'spec_helper'

describe 'apt::preferences' do

  describe file('/etc/apt/preferences.d/imagemagick-common.pref') do
    its(:content) { should match // }
  end

  describe file('/etc/apt/preferences.d/libmagickcore-6.q16-2.pref') do
    its(:content) { should match // }
  end

  describe file('/etc/apt/preferences.d/libmagickwand-6.q16-2.pref') do
    its(:content) { should match // }
  end

  describe command('sudo apt-get -y install imagemagick') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /Unpacking imagemagick-common \(8:6\.8\.9\.9-5\+deb8u2\)/}
  end
end
