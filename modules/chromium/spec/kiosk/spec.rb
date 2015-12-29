require 'spec_helper'

describe 'chromium::kiosk' do

  describe package ('chromium-browser') do
    it { should be_installed }
  end

  describe package ('lightdm') do
    it { should be_installed }
  end

  describe file ('/usr/local/bin/chromium-kiosk.sh') do
    it { should be_executable }
  end

end
