require 'spec_helper'

describe package('vagrant') do
  it { should be_installed }
end
