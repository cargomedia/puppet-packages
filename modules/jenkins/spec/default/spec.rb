require 'spec_helper'

describe package('jenkins') do
  it { should be_installed }
end
