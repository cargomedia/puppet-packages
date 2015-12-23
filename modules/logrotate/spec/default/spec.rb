require 'spec_helper'

describe 'logrotate' do

  describe package('logrotate') do
    it { should be_installed }
  end

  describe command('/etc/cron.daily/logrotate') do
    its(:exit_status) { should eq 0 }
  end

end
