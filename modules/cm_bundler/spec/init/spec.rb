require 'spec_helper'

describe 'cm_bundler' do

  describe package('cm_bundler') do
    it { should be_installed.by('npm') }
  end

  describe command('cm_bundler --version') do
    its(:exit_status) { should eq 0 }
  end
end
