require 'spec_helper'

describe command('php --ri xdebug') do
  it { should return_exit_status 0 }
  its(:stdout) { should_not match /Warning.*xdebug.*loaded/ }
end
