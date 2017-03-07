require 'spec_helper'

describe 'goreplay' do

  describe command('gor') do
    its(:exit_status) { should eq 1 }
    its(:stdout) { should match /^Version:/ }
  end
end
