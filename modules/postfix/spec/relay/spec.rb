require 'spec_helper'
require 'base64'

describe 'postfix' do

  describe package('postfix') do
    it { should be_installed }
  end

  describe service('postfix') do
    it { should be_running }
  end

  credentials1 = Base64.strict_encode64("\0foo\0bar")

  describe file('/tmp/2525') do
    it 'is a file' do
      expect(subject).to be_file
    end
    it 'contains credentials foo:bar' do
      expect(subject).to contain(credentials1).after(/AUTH PLAIN/)
    end
    it 'is contains test mail #1' do
      expect(subject).to contain('<filter_2525@example.com>').after(/RCPT TO/)
    end
    it 'is contains test mail #2' do
      expect(subject).to contain('<filter_2828@example.com>').after(/RCPT TO/)
    end
  end
end
