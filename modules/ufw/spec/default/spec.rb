require 'spec_helper'

describe 'ufw::default' do

  describe package('ufw') do
    it { should be_installed }
  end

  describe file('/var/log/ufw/ufw.log.1') do
    it { should be_file }
    its(:content) { should match /foo to bar/}
  end

  describe file ('/var/log/syslog.1') do
    its(:content) { should_not match /foo to bar/}
  end

  describe file ('/var/log/ufw/ufw.log') do
    it { should be_file }
  end

end
