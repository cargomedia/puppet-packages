require 'spec_helper'

describe 'earlyoom' do

  describe command('earlyoom -h') do
    its(:exit_status) { should eq 1 }
  end

  describe service('earlyoom') do
    it { should be_running }
  end
end
