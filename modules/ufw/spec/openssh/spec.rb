require 'spec_helper'

describe 'ufw::application:openssh' do

  describe command('ufw app info OpenSSH') {
    its(:stdout) { should match /22\/tcp/ }
  }

  describe iptables do
    it { should have_rule('-m multiport --dports 22').with_table('filter').with_chain('ufw-user-input') }
  end
end
