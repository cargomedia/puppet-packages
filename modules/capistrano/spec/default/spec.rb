require 'spec_helper'

describe 'capistrano' do

  describe command('gem list') do
    its(:stdout) { should match 'capistrano' }
  end

  describe command('cap --version') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match 'Capistrano' }
  end
end
