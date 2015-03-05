require 'spec_helper'

describe 'librarian_puppet' do

  describe command('cd && librarian-puppet config') do
    its(:stdout) { should match /master-global: false/ }
    its(:stdout) { should match /slave-global: 88/ }
    its(:stdout) { should_not match /master-local/ }
    its(:stdout) { should_not  match /slave-local/ }
  end

  describe command('cd /tmp && librarian-puppet config') do
    its(:stdout) { should match /master-global: false/ }
    its(:stdout) { should match /slave-global: 88/ }
    its(:stdout) { should match /master-local: 3/ }
    its(:stdout) { should match /slave-local: true/ }
  end
end
