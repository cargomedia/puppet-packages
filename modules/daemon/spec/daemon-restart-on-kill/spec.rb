require 'spec_helper'

describe 'daemon' do

  describe service('my-program') do
    it { should be_enabled }
    it { should be_running }
  end

  describe process("my-program") do
    its(:count) { should eq 1 }
  end
end
