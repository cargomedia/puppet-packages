require 'spec_helper'

describe 'postfix' do

  describe package('postfix') do
    it { should be_installed }
  end

  describe service('postfix') do
    it { should be_running }
  end

  describe command('timeout 10  bash  -c \'until (grep "status=sent" /var/log/mail.log);do sleep 1;done\'') do
    it "postfix has correctly sent the test mail" do
      expect(subject.exit_status).to eq 0
    end
  end

  describe file('/var/spool/mail/bar') do
    it 'is a file' do
      expect(subject).to be_file
    end
    it 'is a mail for foo forwarded to bar' do
      expect(subject).to contain('foo@localhost').after(/^To:/)
    end
  end
end
