require 'spec_helper'

describe 'ruby::gem' do

  describe package('ruby') do
    it { should be_installed }
  end

  describe command('which gem') do
    its(:exit_status) { should eq 0 }
  end

  describe command('gem list') do
    its(:stdout) { should match 'deep_merge' }
  end
end
