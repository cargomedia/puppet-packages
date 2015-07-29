require 'spec_helper'

describe 'nodejs::package' do

  describe command('cd /tmp/foo && npm list') do
    its(:stdout) { should match /async@1.3.0$/ }
  end

  describe file('/tmp/foo/node_modules') do
    it { should be_directory }
    it { should be_owned_by 'bob' }
  end
end
