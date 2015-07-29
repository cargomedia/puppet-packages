require 'spec_helper'

describe 'nodejs::package' do

  describe command('cd /tmp/foo && npm list') do
    its(:stdout) { should match /async@/ }
    its(:stdout) { should_not match /async@1.3.0$/ }
  end
end
