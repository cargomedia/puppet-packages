require 'spec_helper'

describe 'autoprefixer' do

  describe package('autoprefixer') do
    it { should be_installed.by('npm') }
  end

  describe command('autoprefixer --version') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match 'autoprefixer' }
  end
end
