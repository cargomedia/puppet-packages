define backup::agent (
  $server_id,
  $sourceType,
  $host,
  $source,
  $destination,
  $options = '--no-file-statistics --no-compare-inode',
  $cronTimeHour = 4,
  $cronTimeMinute = 0
) {

  if ('lvm' != $sourceType and 'mysql' != $sourceType and 'mysql-dump' != $sourceType and 'dir' != $sourceType) {
    fail("Unknown source type ${sourceType}")
  }

  require 'backup::agent_common'

  ssh::auth::id {$name:
    id => "backup-agent@${server_id}",
    user => 'root',
  }

  cron {"backup-${name}":
    command => "/usr/local/bin/backup-create.sh -h '${host}' -s '${source}' -d '${destination}' -o '${options}' -t '${sourceType}'",
    user    => 'root',
    minute  => $cronTimeMinute,
    hour    => $cronTimeHour,
  }

  cron {"backup-check-${name}":
    command => "/usr/local/bin/backup-check.sh -h '${host}' -d '${destination}'",
    user    => 'root',
    minute  => 10,
    hour    => 3,
  }
}
