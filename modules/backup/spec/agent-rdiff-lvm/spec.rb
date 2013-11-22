require 'spec_helper'

describe package('rdiff-backup') do
  it { should be_installed }
end

describe file('/root/bin/backup.sh') do
  it {should be_file }
  its(:content) { should match /ORIG_VOLUME=".*dev.*vg01.*storage01"/ }
end

describe file('/root/bin/check-backup.sh') do
  it {should be_file }
end