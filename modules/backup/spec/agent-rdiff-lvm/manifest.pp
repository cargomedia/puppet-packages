node default {

  class {'backup::agent::rdiff':
    sourceType => 'lvm',
    host => 'localhost',
    source => '/dev/vg01/storage01',
    destination => '/home/backup/shared',
    options => '--no-eas --no-file-statistics --no-carbonfile --no-acls --no-compare-inode',
    cronTimeMinute => 30,
    cronTimeHour => 8,
  }

}