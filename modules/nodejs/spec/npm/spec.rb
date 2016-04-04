require 'spec_helper'

describe 'package provider npm' do

  describe command('npm list socket-redis -g') do
    its(:stdout) { should match 'socket-redis' }
  end
end
