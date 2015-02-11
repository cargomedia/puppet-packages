require 'spec_helper'

describe 'package provider npm' do

  describe command('npm list redis -g') do
    its(:stdout) { should match 'redis' }
  end
end
