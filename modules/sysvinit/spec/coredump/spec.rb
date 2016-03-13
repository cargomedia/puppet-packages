require 'spec_helper'

describe 'sysvinit::script' do

  describe command('ls /tmp/core.bar.*') do
    its(:exit_status) { should eq 0 }
  end

end
