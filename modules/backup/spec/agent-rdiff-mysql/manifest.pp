node default {

  class {'backup::agent::rdiff':
    sourceType => 'mysql',
    host => 'localhost',
    source => '/raid-backup',
    destination => '/home/backup/shared'
  }

}