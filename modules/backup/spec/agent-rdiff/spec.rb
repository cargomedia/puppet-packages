require 'spec_helper'

describe package('rdiff-backup') do
  it { should be_installed }
end


describe file('/usr/local/bin/backup-my-lvm.sh') do
  it { should be_file }
  its(:content) { should match /ORIG_VOLUME=".*dev.*vg01.*storage01"/ }
end

describe file('/usr/local/bin/backup-check-my-lvm.sh') do
  it { should be_file }
end

describe cron do
  it { should have_entry('30 8 * * * /usr/local/bin/backup-my-lvm.sh').with_user('root') }
end


describe file('/usr/local/bin/backup-my-mysql.sh') do
  it { should be_file }
  its(:content) { should match /.*var.*lib.*mysql/ }
end

describe file('/usr/local/bin/backup-check-my-mysql.sh') do
  it { should be_file }
end

describe cron do
  it { should have_entry('10 5 * * * /usr/local/bin/backup-my-mysql.sh').with_user('root') }
end
