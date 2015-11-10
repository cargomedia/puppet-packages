require 'spec_helper'

describe 'janus::deps:libsrtp:' do

  describe command('ldconfig -v 2>/dev/null |grep -qE "libsrtp\."') do
    its(:exit_status) { should eq 0 }
  end

end
