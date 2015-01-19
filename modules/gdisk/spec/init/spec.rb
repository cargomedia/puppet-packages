require 'spec_helper'

describe package('gdisk') do
  it { should be_installed }
end
