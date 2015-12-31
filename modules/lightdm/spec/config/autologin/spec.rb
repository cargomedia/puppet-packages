require 'spec_helper'

describe 'lightdm::config::autologin' do

  describe package('lightdm') do
    it { should be_installed }
  end

  describe command('lightdm --show-config') do
    its(:stderr) { should match 'autologin-user=bob' }
  end

end
