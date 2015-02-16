require 'spec_helper'

describe 'monit alerting' do

  describe file('/etc/monit/conf.d/alert') do
    its(:content) { should match /set alert/ }
  end

  describe command('monit-alert foobar') do
    its(:exit_status) { should eq 1 }
  end

  describe command('monit-alert none') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/etc/monit/conf.d/alert') do
    its(:content) { should_not match /set alert/ }
  end

  describe command('monit-alert default') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/etc/monit/conf.d/alert') do
    its(:content) { should match /set alert/ }
  end

  describe process('monit') do
    it { should be_running }
  end
end
