node default {

  class {'backup::agent::rdiff':
    sourceType => 'mysql',
    host => 'localhost',
    source => '/var/lib/mysql',
    destination => '/home/backup/db',
    options => '--no-eas --no-file-statistics --no-carbonfile --no-acls --no-compare-inode',
  }
}