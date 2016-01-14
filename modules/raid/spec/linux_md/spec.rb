require 'spec_helper'

describe 'raid::linux_md' do

  describe command('monit summary') do
    its(:stdout) { should match /Program 'raid-linux-md'/ }
  end
end
