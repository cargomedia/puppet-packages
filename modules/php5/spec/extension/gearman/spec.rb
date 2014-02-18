require 'spec_helper'

describe command('php --ri gearman') do
  it { should return_exit_status 0 }
  its(:stdout) { should_not match /Warning.*gearman.*loaded/ }
end
