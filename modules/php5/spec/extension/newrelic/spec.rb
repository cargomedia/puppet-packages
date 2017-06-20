require 'spec_helper'

describe 'php5::extension::newrelic' do

  describe package('newrelic-php5') do
    it { should be_installed }
  end

  describe command('php --re newrelic') do
    its(:exit_status) { should eq 0 }
  end

  describe command('php --ri newrelic') do
    its(:stdout) { should match /appname => bar/ }
    its(:stdout) { should match /enabled => no/ }
    its(:stdout) { should match /browser_monitoring\.auto_instrument => enabled/ }
  end

  describe service('fluentd') do
    it { should be_running }
  end
end
