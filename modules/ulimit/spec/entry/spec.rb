require 'spec_helper'

describe 'ulimit::entry' do

  describe file('/etc/security/limits.d/mysql') do
    its(:content) { should match 'mysql - nofile 16384' }
  end
end
