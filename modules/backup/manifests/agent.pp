define backup::agent (
  $server_id,
  $sourceType,
  $host,
  $source,
  $destination,
  $options = '--no-file-statistics --no-compare-inode',
  $remove_after = '4W', # see man page for rdiff-backup (http://linux.die.net/man/1/rdiff-backup), section --remove-after time_spec
  $cronTimeHour = 4,
  $cronTimeMinute = 0
) {

  if ('lvm' != $sourceType and 'mysql' != $sourceType and 'mysql-dump' != $sourceType and 'dir' != $sourceType) {
    fail("Unknown source type ${sourceType}")
  }

  require 'backup::agent_common'

  ssh::auth::id { $name:
    id   => "backup-agent@${server_id}",
    user => 'root',
  }

  cron { "backup-${name}":
    command => "/usr/local/bin/backup-run.sh ${sourceType} create -h '${host}' -s '${source}' -d '${destination}' -o '${options}' -t '${sourceType}' -r '${remove_after}'",
    user    => 'root',
    minute  => $cronTimeMinute,
    hour    => $cronTimeHour,
  }

  cron { "backup-check-${name}":
    command => "/usr/local/bin/backup-run.sh ${sourceType} check -h '${host}' -d '${destination}'",
    user    => 'root',
    minute  => 10,
    hour    => 3,
  }
}
