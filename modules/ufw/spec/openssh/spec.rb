require 'spec_helper'

describe 'ufw::application:openssh' do

  describe command('ufw app info OpenSSH') {
    its(:stdout) { should match /22\/tcp/ }
  }

end
