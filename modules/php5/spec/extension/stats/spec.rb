require 'spec_helper'

describe command('php --ri stats') do
  it { should return_exit_status 0 }
end

describe file('/var/log/php/error.log') do
  its(:content) { should_not match /Warning.*stats.*already loaded/ }
end
