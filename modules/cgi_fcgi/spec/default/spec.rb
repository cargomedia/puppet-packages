require 'spec_helper'

describe 'cgi_fcgi' do

  describe package('libfcgi0ldbl') do
    it { should be_installed }
  end

  describe command('which cgi-fcgi') do
    its(:exit_status) { should eq 0 }
  end
end
