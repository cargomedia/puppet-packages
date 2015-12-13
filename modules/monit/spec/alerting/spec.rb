require 'spec_helper'

describe 'monit alerting' do

  describe file('/etc/monit/conf.d/alert') do
    its(:content) { should match /set alert/ }
  end

  describe process('monit') do
    it { should be_running }
  end

  describe command('> /var/mail/nobody') do
    its(:exit_status) { should eq 0 }
  end

  # alerting: something-invalid

  describe command('monit-alert something-invalid') do
    its(:exit_status) { should eq 1 }
  end

  describe command('monit summary') do
    its(:stdout) { should match /'foo'.*Running/ }
  end
  describe command('grep -c "Description: Monit reloaded" /var/mail/nobody') do
    its(:stdout) { should match '0' }
  end
  describe command('grep -c "Description: monitor action done" /var/mail/nobody') do
    its(:stdout) { should match '0' }
  end

  # alerting: none

  describe command('monit-alert none && monit unmonitor foo && sleep 1') do
    its(:exit_status) { should eq 0 }
  end

  describe command('monit summary') do
    its(:stdout) { should match /'foo'.*Not monitored/ }
  end
  describe command('grep -c "Description: Monit reloaded" /var/mail/nobody') do
    its(:stdout) { should match '0' }
  end
  describe command('grep -c "Description: unmonitor action done" /var/mail/nobody') do
    its(:stdout) { should match '0' }
  end

  describe command('monit monitor foo && sleep 1') do
    its(:exit_status) { should eq 0 }
  end

  describe command('monit summary') do
    its(:stdout) { should_not match /'foo'.*Not monitored/ }
  end
  describe command('grep -c "Description: monitor action done" /var/mail/nobody') do
    its(:stdout) { should match '0' }
  end

  # alerting: default

  describe command('monit-alert default && monit unmonitor foo && sleep 1') do
    its(:exit_status) { should eq 0 }
  end

  describe command('monit summary') do
    its(:stdout) { should match /'foo'.*Not monitored/ }
  end
  describe command('grep -c "Description: Monit reloaded" /var/mail/nobody') do
    its(:stdout) { should match '1' }
  end
  describe command('grep -c "Description: unmonitor action done" /var/mail/nobody') do
    its(:stdout) { should match '1' }
  end

  describe command('monit monitor foo && sleep 2') do
    its(:exit_status) { should eq 0 }
  end

  describe command('monit summary') do
    its(:stdout) { should_not match /'foo'.*Not monitored/ }
  end
  describe command('grep -c "Description: monitor action done" /var/mail/nobody') do
    its(:stdout) { should match '1' }
  end

end
