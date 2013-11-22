require 'spec_helper'

describe package('rdiff-backup') do
  it { should be_installed }
end

describe file('/root/bin/check-backup.sh') do
  it {should be_file }
end

describe file('/root/bin/restore-db.sh') do
  it {should be_file }
end

describe file('/root/bin/restore-shared.sh') do
  it {should be_file }
end

describe file('/etc/monit/conf.d/fs-check-home') do
  it {should be_file }
end