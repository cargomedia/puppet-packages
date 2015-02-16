require 'spec_helper'

describe 'ruby::gem::bundler' do

  describe package('bundler') do
    it { should be_installed.by('gem').with_version('1.6.4') }
  end

  describe command('bundle --version') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match 'Bundler version' }
  end
end
