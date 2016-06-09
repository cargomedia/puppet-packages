require 'spec_helper'

describe 'ruby::gem::bundler' do

  describe package('bundler') do
    it { should be_installed.by('gem') }
  end

  describe command('bundle --version') do
    its(:exit_status) { should eq 0 }
  end
end
