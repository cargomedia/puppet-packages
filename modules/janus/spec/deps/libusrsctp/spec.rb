require 'spec_helper'

describe 'janus::deps::libusrsctp' do

  describe command('ldconfig -v 2>/dev/null |grep -qE "libusrsctp\."') do
    its(:exit_status) { should eq 0 }
  end

end
