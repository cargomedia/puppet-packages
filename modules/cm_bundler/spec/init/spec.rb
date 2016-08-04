require 'spec_helper'

describe 'cm_bundler' do

  describe package('cm-bundler') do
    it { should be_installed.by('npm') }
  end

  describe command('cm-bundler --version') do
    its(:exit_status) { should eq 0 }
  end
end
