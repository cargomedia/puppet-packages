node default {

  backup::agent {'my-lvm':
    server_id => 'my-backup-server',
    sourceType => 'lvm',
    host => 'localhost',
    source => '/dev/vg01/storage01',
    destination => '/home/backup/shared',
    options => '--no-eas --no-file-statistics --no-carbonfile --no-acls --no-compare-inode',
    cronTimeMinute => 30,
    cronTimeHour => 8,
  }

  backup::agent {'my-mysql':
    server_id => 'my-backup-server',
    sourceType => 'mysql',
    host => 'localhost',
    source => '/var/lib/mysql',
    destination => '/home/backup/db',
    options => '--no-eas --no-file-statistics --no-carbonfile --no-acls --no-compare-inode',
    cronTimeMinute => 10,
    cronTimeHour => 5,
  }

  backup::agent {'my-mysql-dump':
    server_id => 'my-backup-server',
    sourceType => 'mysql-dump',
    host => 'localhost',
    source => 'mysql',
    destination => '/home/backup/db-dump',
    options => '--no-eas --no-file-statistics --no-carbonfile --no-acls --no-compare-inode',
    cronTimeMinute => 30,
    cronTimeHour => 7,
  }

  backup::agent {'my-file-system':
    server_id => 'my-backup-file',
    sourceType => 'dir',
    host => 'localhost',
    source => '/tmp',
    destination => '/home/backup/dir',
    options => '--no-eas --no-file-statistics --no-carbonfile --no-acls --no-compare-inode',
    cronTimeMinute => 5,
    cronTimeHour => 1,
  }

}
