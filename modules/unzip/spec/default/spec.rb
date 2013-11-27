require 'spec_helper'

describe package('unzip') do
  it { should be_installed }
end
