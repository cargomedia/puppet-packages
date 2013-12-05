require 'spec_helper'

describe package('rdiff-backup') do
  it { should be_installed }
end
