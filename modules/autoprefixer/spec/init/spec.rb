require 'spec_helper'

describe 'autoprefixer' do

  describe package('autoprefixer') do
    it { should be_installed.by('npm') }
  end

  describe command('autoprefixer --version') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match 'autoprefixer' }
  end

  describe command('cd /usr/lib/node_modules/autoprefixer && npm ls') do
    its(:stdout) { should match /caniuse-db@1.0.30000246$/ }
  end
end
