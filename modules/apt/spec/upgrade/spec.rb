require 'spec_helper'

describe 'apt::upgrade' do

  describe command('apt-get upgrade -y') do
    its(:stdout) { should match('0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.') }
  end

end
