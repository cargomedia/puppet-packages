require 'spec_helper'

describe 'janus::deps::libwebsockets' do

  describe command('ldconfig -v 2>/dev/null |grep -qE "libwebsockets\."') do
    its(:exit_status) { should eq 0 }
  end

end
