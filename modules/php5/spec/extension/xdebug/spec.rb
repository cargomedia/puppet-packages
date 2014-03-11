require 'spec_helper'

describe command('php --ri xdebug') do
  it { should return_exit_status 0 }
  its(:stdout) { should_not match /Warning.*xdebug.*loaded/ }
  its(:stdout) { should match /xdebug.remote_host => 127.0.0.1/ }
  its(:stdout) { should match /xdebug.remote_port => 1234/ }
  its(:stdout) { should match /xdebug.remote_autostart => On/ }
  its(:stdout) { should match /xdebug.remote_connect_back => Off/ }
end
