require 'spec_helper'

describe 'janus::deps:libsrtp:' do

  describe command('cd /usr/local/bin; ./rtpw_test_gcm.sh') do
    its(:exit_status) { should eq 0 }
  end

  describe command('cd /usr/local/bin; ./rtpw_test.sh') do
    its(:exit_status) { should eq 0 }
  end

end
