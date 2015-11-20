require 'spec_helper'

describe 'git::repository' do

  describe file('/tmp/repository') do
    it { should be_directory }
    it { should be_owned_by 'bob' }
  end

  describe command('cd /tmp/repository && git log --oneline | wc -l') do
    its(:stdout) { should match '1' }
  end
end
