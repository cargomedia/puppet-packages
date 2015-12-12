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

  credentials1 = Base64.strict_encode64("\0foo\0bar")

  describe file('/tmp/11101') do
    it 'is a file' do
      expect(subject).to be_file
    end
    it 'contains credentials foo:bar' do
      expect(subject).to contain(credentials1).after(/AUTH PLAIN/)
    end
    it 'is a mail filtered correctly' do
      expect(subject).to contain('<filter_11101@example.com>').after(/RCPT TO/)
    end
  end

  credentials2 = Base64.strict_encode64("\0bar\0foo")

  describe file('/tmp/11102') do
    it 'is a file' do
      expect(subject).to be_file
    end
    it 'contains credentials bar:foo' do
      expect(subject).to contain(credentials2).after(/AUTH PLAIN/)
    end
    it 'is a mail filtered correctly' do
      expect(subject).to contain('<filter_11102@example.com>').after(/RCPT TO/)
    end
  end


end
