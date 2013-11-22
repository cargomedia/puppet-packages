require 'spec_helper'

describe package('rdiff-backup') do
  it { should be_installed }
end

describe file('/etc/monit/conf.d/fs-check-home') do
  it {should be_file }
end