require 'spec_helper'

describe 'foreman_debian' do
  describe package('foreman_debian') do
    it { should be_installed.by('gem') }
  end

  describe command('which foreman-debian') do
    its(:exit_status) { should eq 0 }
  end
end
