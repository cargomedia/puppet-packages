require 'spec_helper'

describe 'backup::agent' do

  describe package('rdiff-backup') do
    it { should be_installed }
  end

  describe file('/usr/local/bin/backup-run.sh') do
    it { should be_file }
  end

  describe file('/usr/local/bin/backup-create.sh') do
    it { should be_file }
  end

  describe file('/usr/local/bin/backup-check.sh') do
    it { should be_file }
  end

  describe command("/usr/local/bin/backup-run.sh foo") do
    its(:stdout) { should be_empty }
    its(:stderr) { should be_empty }
  end

  describe command("/usr/local/bin/backup-run.sh check -h foo -d /bar") do
    its(:stdout) { should be_empty }
    its(:stderr) { should be_empty }
  end

  describe command('journalctl --no-pager') do
    its(:stdout) { should match /mysql\.backup-foo failed with exit code 127, see \/tmp\/mysql.backup-foo\.\d+\.out/ }
    its(:stdout) { should match /mysql\.backup-check failed with exit code 1, see \/tmp\/mysql.backup-check\.\d+\.out/ }
  end

  describe command('cat /tmp/mysql.backup-foo.*.out') do
    its(:stdout) { should match /\/usr\/local\/bin\/backup-foo\.sh: No such file or directory/ }
  end

  describe command('cat /tmp/mysql.backup-check.*.out') do
    its(:stdout) { should match /Couldn\'t start up the remote connection by executing/ }
  end

  describe cron do
    it { should have_entry("30 8 * * * /usr/local/bin/backup-run.sh create -h 'localhost' -s '/dev/vg01/storage01' -d '/home/backup/shared' -o '--no-eas --no-file-statistics --no-carbonfile --no-acls --no-compare-inode' -t 'lvm' -r '4W'").with_user('root') }
  end

  describe cron do
    it { should have_entry("10 3 * * * /usr/local/bin/backup-run.sh check -h 'localhost' -d '/home/backup/shared'").with_user('root') }
  end

  describe cron do
    it { should have_entry("10 5 * * * /usr/local/bin/backup-run.sh create -h 'localhost' -s '/var/lib/mysql' -d '/home/backup/db' -o '--no-eas --no-file-statistics --no-carbonfile --no-acls --no-compare-inode' -t 'mysql' -r '5D'").with_user('root') }
  end

  describe cron do
    it { should have_entry("10 3 * * * /usr/local/bin/backup-run.sh check -h 'localhost' -d '/home/backup/db'").with_user('root') }
  end

  describe cron do
    it { should have_entry("30 7 * * * /usr/local/bin/backup-run.sh create -h 'localhost' -s 'mysql' -d '/home/backup/db-dump' -o '--no-eas --no-file-statistics --no-carbonfile --no-acls --no-compare-inode' -t 'mysql-dump' -r '4W'").with_user('root') }
  end

  describe cron do
    it { should have_entry("10 3 * * * /usr/local/bin/backup-run.sh check -h 'localhost' -d '/home/backup/db-dump'").with_user('root') }
  end

  describe cron do
    it { should have_entry("5 1 * * * /usr/local/bin/backup-run.sh create -h 'localhost' -s '/tmp' -d '/home/backup/dir' -o '--no-eas --no-file-statistics --no-carbonfile --no-acls --no-compare-inode' -t 'dir' -r '4W'").with_user('root') }
  end

  describe cron do
    it { should have_entry("10 3 * * * /usr/local/bin/backup-run.sh check -h 'localhost' -d '/home/backup/dir'").with_user('root') }
  end
end
