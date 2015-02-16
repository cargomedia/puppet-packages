require 'spec_helper'

describe 'nodejs' do

  describe command('nodejs -v') do
    its(:exit_status) { should eq 0 }
  end

  describe command('node -v') do
    its(:exit_status) { should eq 0 }
  end

  describe command('npm -v') do
    its(:exit_status) { should eq 0 }
  end
end
