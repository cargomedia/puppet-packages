require 'spec_helper'

describe package('rdiff-backup') do
  it { should be_installed }
end


describe file('/usr/local/bin/backup-create.sh') do
  it { should be_file }
end

describe file('/usr/local/bin/backup-check.sh') do
  it { should be_file }
end


describe cron do
  it { should have_entry("30 8 * * * /usr/local/bin/backup-create.sh -h 'localhost' -s '/dev/vg01/storage01' -d '/home/backup/shared' -o '--no-eas --no-file-statistics --no-carbonfile --no-acls --no-compare-inode' -t 'lvm'").with_user('root') }
end

describe cron do
  it { should have_entry("10 3 * * * /usr/local/bin/backup-check.sh -h 'localhost' -d '/home/backup/shared'").with_user('root') }
end

describe cron do
  it { should have_entry("10 5 * * * /usr/local/bin/backup-create.sh -h 'localhost' -s '/var/lib/mysql' -d '/home/backup/db' -o '--no-eas --no-file-statistics --no-carbonfile --no-acls --no-compare-inode' -t 'mysql'").with_user('root') }
end

describe cron do
  it { should have_entry("10 3 * * * /usr/local/bin/backup-check.sh -h 'localhost' -d '/home/backup/db'").with_user('root') }
end

describe cron do
  it { should have_entry("30 7 * * * /usr/local/bin/backup-create.sh -h 'localhost' -s 'mysql' -d '/home/backup/db-dump' -o '--no-eas --no-file-statistics --no-carbonfile --no-acls --no-compare-inode' -t 'mysql-dump'").with_user('root') }
end

describe cron do
  it { should have_entry("10 3 * * * /usr/local/bin/backup-check.sh -h 'localhost' -d '/home/backup/db-dump'").with_user('root') }
end

describe cron do
  it { should have_entry("5 1 * * * /usr/local/bin/backup-create.sh -h 'localhost' -s '/tmp' -d '/home/backup/dir' -o '--no-eas --no-file-statistics --no-carbonfile --no-acls --no-compare-inode' -t 'dir'").with_user('root') }
end

describe cron do
  it { should have_entry("10 3 * * * /usr/local/bin/backup-check.sh -h 'localhost' -d '/home/backup/dir'").with_user('root') }
end
