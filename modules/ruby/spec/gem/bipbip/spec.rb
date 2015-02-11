require 'spec_helper'

describe 'ruby::gem::bipbip' do

  describe command('gem list') do
    its(:stdout) { should match 'bipbip' }
    its(:stdout) { should match '0.5.16' }
  end
end
