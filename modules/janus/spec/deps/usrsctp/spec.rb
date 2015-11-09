require 'spec_helper'

describe 'janus::deps::usrsctp' do

  describe command('ldconfig -v 2>/dev/null |grep -q libusrsctp') do
    its(:exit_status) { should eq 0 }
  end

end
