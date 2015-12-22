require 'spec_helper'

describe 'kernel::modprobe_blacklist' do

  describe command('modprobe --showconfig') do
    its(:stdout) { should match "blacklist foo1\n" }
    its(:stdout) { should match "blacklist foo2\n" }
    its(:stdout) { should match "blacklist bar1\n" }
  end

end
