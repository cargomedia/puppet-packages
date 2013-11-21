node default {

  class {'backup::agent::rdiff':
    sourceType => 'lvm',
    host => 'localhost',
    volume => '/dev/vg01/storage01',
    source => '/raid-backup',
    destination => '/home/backup/shared',
    options => '--no-eas --no-file-statistics --no-carbonfile --no-acls --no-compare-inode',
  }

}