require 'spec_helper'

describe command('test -f /etc/monit/conf.d/puppet') do
  its(:exit_status) { should eq 1 }
end
