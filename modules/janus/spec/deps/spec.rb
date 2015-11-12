require 'spec_helper'

describe 'janus::deps' do

  describe command('ldconfig -v 2>/dev/null |grep -qE "libsrtp\."') do
    its(:exit_status) { should eq 0 }
  end

  describe command('ldconfig -v 2>/dev/null |grep -qE "libusrsctp\."') do
    its(:exit_status) { should eq 0 }
  end

  describe command('ldconfig -v 2>/dev/null |grep -qE "libwebsockets\."') do
    its(:exit_status) { should eq 0 }
  end

end
