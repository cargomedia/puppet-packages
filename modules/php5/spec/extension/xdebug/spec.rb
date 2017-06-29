require 'spec_helper'

describe 'php5::extension::xdebug' do

  describe command('php --ri xdebug') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /xdebug.remote_host => 127.0.0.1/ }
    its(:stdout) { should match /xdebug.remote_port => 1234/ }
    its(:stdout) { should match /xdebug.remote_autostart => On/ }
    its(:stdout) { should match /xdebug.remote_connect_back => Off/ }
  end
end
