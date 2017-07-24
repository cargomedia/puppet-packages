require 'spec_helper'

describe 'nodejs' do

  describe file('/etc/apt/sources.list.d/nodesource.list') do
    it { should exist }
  end

  describe command('nodejs -v') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /v6\./}
  end

  describe command('node -v') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /v6\./}
  end

  describe command('npm -v') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /3\.10\./}
  end
end
