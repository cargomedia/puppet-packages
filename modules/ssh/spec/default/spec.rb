require 'spec_helper'

describe 'ssh' do

  describe file('/etc/ssh/sshd_config') do
    its(:content) { should match /PermitRootLogin without-password/ }
  end
end
