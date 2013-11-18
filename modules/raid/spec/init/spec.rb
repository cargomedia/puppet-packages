require 'spec_helper'

# todo: Test auto-including from facts
describe file('/tmp') do
  it { should be_directory }
end
