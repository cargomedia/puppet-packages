require 'spec_helper'

describe 'cron' do

  describe package('cron') do
    it { should be_installed }
  end

  describe service('cron') do
    it { should be_enabled }
    it { should be_running }
  end

end
