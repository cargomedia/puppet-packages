require 'spec_helper'

describe 'postfix' do

  describe package('postfix') do
    it { should be_installed }
  end

  describe service('postfix') do
    it { should be_running }
  end

  describe file('/var/spool/mail/bar') do
    it "is a file" do
      expect(subject).to be_file
    end
    it "is a mail for foo forwarded to bar" do
      expect(subject).to contain('To: foo@localhost')
    end
  end
end
