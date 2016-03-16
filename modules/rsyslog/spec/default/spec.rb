require 'spec_helper'

describe 'rsyslog::default' do

  describe file('/etc/rsyslog.conf') do
    it { should be_file }
  end

  describe command('grep -r "/var/log/syslog" /etc/rsyslog.d | wc -l') do
    its(:stdout) { should match('1') }
  end

  describe package('rsyslog') do
    it { should be_installed }
  end

  describe service('rsyslog') do
    it { should be_running }
  end

  describe file('/var/log/syslog') do
    it { should be_file }
    it { should be_mode 707 }
    its(:content) { should match(/my-test$/) }
    it 'logs only once' do
      expect(subject.content.scan(/my-test/).count).to eq(1)
    end
  end
end
