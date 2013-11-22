require 'spec_helper'

describe package('lvm2') do
  it {should be_installed }
end