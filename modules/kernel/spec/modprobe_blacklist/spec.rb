require 'spec_helper'

describe 'kernel::modprobe_blacklist' do

  describe command('modprobe --showconfig') do
    its(:stdout) { should match "blacklist blowfish_common\n" }
    its(:stdout) { should match "blacklist foo1\n" }
    its(:stdout) { should match "blacklist foo2\n" }
  end

  describe kernel_module('blowfish_common') do
    it { should_not be_loaded }
  end

end
