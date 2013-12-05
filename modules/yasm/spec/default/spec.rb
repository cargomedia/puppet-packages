require 'spec_helper'

describe file('/usr/local/bin/yasm') do
  it { should be_executable }
end
