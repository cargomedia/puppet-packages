require 'spec_helper'

describe package('rdiff-backup') do
  it { should be_installed }
end

describe package('python') do
  it { should be_installed }
end
