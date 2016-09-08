require 'spec_helper'

describe 'apt::preference' do

  describe file('/etc/apt/preferences.d/imagemagick-common.pref') do
    its(:content) { should match /^Package: imagemagick-common$/ }
    its(:content) { should match /^Pin: version 8:6.8.9.9\-5\+deb8u2$/ }
    its(:content) { should match /^Pin-Priority: 1000$/ }
  end

end
