require 'spec_helper'
require 'base64'

describe 'postfix' do

  describe package('postfix') do
    it { should be_installed }
  end

  describe service('postfix') do
    it { should be_running }
  end

  describe file('/etc/postfix/header_checks') do
    it 'is a file' do
      expect(subject).to be_file
    end
    it 'has filters' do
      expect(subject).to contain('filter_11101').after(/^\/\^To:/)
      expect(subject).to contain('filter_11102').after(/^\/\^To:/)
    end
  end

  credentials0 = Base64.strict_encode64("\0user0\0passwd0")

  describe file('/tmp/11100') do
    it 'is a file' do
      expect(subject).to be_file
    end
    it 'contains credentials user0:passwd0' do
      expect(subject).to contain(credentials0).after(/AUTH PLAIN/)
    end
    it 'is a mail' do
      expect(subject).to contain('<no-filter@example.com>').after(/RCPT TO/)
    end
  end

  credentials1 = Base64.strict_encode64("\0user1\0passwd1")

  describe file('/tmp/11101') do
    it 'is a file' do
      expect(subject).to be_file
    end
    it 'contains credentials user1:passwd1' do
      expect(subject).to contain(credentials1).after(/AUTH PLAIN/)
    end
    it 'is a mail filtered correctly' do
      expect(subject).to contain('<filter_11101@example.com>').after(/RCPT TO/)
    end
  end

  credentials2 = Base64.strict_encode64("\0user2\0passwd2")

  describe file('/tmp/11102') do
    it 'is a file' do
      expect(subject).to be_file
    end
    it 'contains credentials user2:passwd2' do
      expect(subject).to contain(credentials2).after(/AUTH PLAIN/)
    end
    it 'is a mail filtered correctly' do
      expect(subject).to contain('<filter_11102@example.com>').after(/RCPT TO/)
    end
  end


end
