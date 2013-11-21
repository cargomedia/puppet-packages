require 'spec_helper'

describe package('xfsprogs') do
  it {should be_installed }
end