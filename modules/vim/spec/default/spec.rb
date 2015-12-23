require 'spec_helper'

describe 'vim' do

  describe package('vim') do
    it { should be_installed }
  end

  describe file('/etc/vim/vimrc.local') do
    it { should be_file }
    its(:content) { should match /set autoindent/ }
  end

end
