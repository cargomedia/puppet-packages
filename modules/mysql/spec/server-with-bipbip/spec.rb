require 'spec_helper'

describe 'mysql::server' do


  # Wait for bipbip to start up
  describe command('/etc/init.d/bipbip start;sleep 2;timeout --signal=9 10 bash -c "while ! (/etc/init.d/bipbip status); do sleep 0.5; done"') do
    its(:exit_status) { should eq 0 }
  end

  describe service('bipbip') do
    it { should be_running }
  end

  describe command('/etc/init.d/mysql status') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match 'Uptime' }
  end

  describe file('/var/log/mysql.err') do
    it "owned by user mysql" do
      expect(subject).to be_owned_by('mysql')
    end
    it "be world-readable" do
      expect(subject).to be_mode(644)
    end
  end

  describe file('/var/log/bipbip/bipbip.log') do
    it "should load the logparser plugin on mysql.err" do
      expect(subject).to contain('Starting plugin log-parser with config {"path"=>"/var/log/mysql.err"')
    end
    it "should not emit an ERR after loading the plugin" do
      expect(subject).not_to contain('ERR').after(/Starting plugin log-parser with config.+mysql.err/)
    end
  end
end
