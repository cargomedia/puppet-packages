require 'spec_helper'

describe package('virtualbox-4.3') do
  it { should be_installed }
end
