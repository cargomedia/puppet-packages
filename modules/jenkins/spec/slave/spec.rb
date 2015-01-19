require 'spec_helper'

describe package('jenkins') do
  it { should_not be_installed }
end

describe package('ntp') do
  it { should be_installed }
end
