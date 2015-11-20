require 'spec_helper'

describe 'git::checkout' do

  describe file('/tmp/checkout') do
    it { should be_directory }
    it { should be_owned_by 'bob' }
  end

  describe command('cd /tmp/checkout && git log --oneline | wc -l') do
    its(:stdout) { should match '1' }
  end
end
