require 'spec_helper'

describe 'monit with bipbip' do

  describe command('monit summary') do
    its(:stdout) { should match /bipbip/ }
  end

end
