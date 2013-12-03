require 'spec_helper'

describe file('/usr/local/bin/x264') do
  it { should be_executable }
end
