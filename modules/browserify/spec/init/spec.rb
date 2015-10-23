require 'spec_helper'

describe 'browserify' do

  describe package('browserify') do
    it { should be_installed.by('npm') }
  end

  describe command('browserify --version') do
    its(:exit_status) { should eq 0 }
  end
end
