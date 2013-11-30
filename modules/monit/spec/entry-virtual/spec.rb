require 'spec_helper'

describe command('test -f /etc/monit/conf.d/puppet') do
  it { should return_exit_status 1 }
end
