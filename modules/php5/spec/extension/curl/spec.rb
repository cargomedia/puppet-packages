require 'spec_helper'

describe command('php --ri curl') do
  it { should return_exit_status 0 }
  its(:stdout) { should_not match /Warning.*curl.*loaded/ }
end
