require 'spec_helper'

describe 'raid' do

# todo: Test auto-including from facts
  describe file('/tmp') do
    it { should be_directory }
  end
end
