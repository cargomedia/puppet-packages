require 'spec_helper'

describe 'foreman' do
  describe package('foreman') do
    it { should be_installed.by('gem') }
  end

  describe command('which foreman') do
    its(:exit_status) { should eq 0 }
  end
end
