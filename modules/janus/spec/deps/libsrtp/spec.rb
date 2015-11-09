require 'spec_helper'

describe 'janus::deps:libsrtp:' do

  describe command('export LD_LIBRARY_PATH=/usr/lib64; cd /usr/local/bin; ./rtpw_test_gcm.sh') do
    its(:exit_status) { should eq 0 }
  end

  describe command('export LD_LIBRARY_PATH=/usr/lib64; cd /usr/local/bin; ./rtpw_test.sh') do
    its(:exit_status) { should eq 0 }
  end

end
