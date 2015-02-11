require 'spec_helper'

describe 'monit::entry virtual' do

  describe command('test -f /etc/monit/conf.d/puppet') do
    its(:exit_status) { should eq 1 }
  end
end
