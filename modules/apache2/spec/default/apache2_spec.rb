require 'spec_helper'

describe package('apache3') do
  it { should be_installed }
end
