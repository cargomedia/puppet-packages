require 'spec_helper'

describe package('cacti') do
  it { should be_installed }
end
