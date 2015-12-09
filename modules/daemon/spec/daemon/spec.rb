require 'spec_helper'

describe 'daemon' do

  describe service('my-program') do
    it { should be_enabled }
    it { should be_running }
  end

  describe process('my-program') do
    its(:user) { should eq 'alice' }
    its(:args) { should match /--foo=12/ }
    it { should be_running }
  end

end
