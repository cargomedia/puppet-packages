require 'spec_helper'

describe 'capistrano' do

  describe command('gem list') do
    its(:stdout) { should match 'capistrano' }
  end
end
