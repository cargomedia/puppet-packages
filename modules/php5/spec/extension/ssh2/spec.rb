require 'spec_helper'

describe command('php --ri ssh2') do
  it { should return_exit_status 0 }
  its(:stdout) { should_not match /Warning.*ssh2.*loaded/ }
end
