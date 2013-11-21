class backup::agent::rdiff (
  $sourceType = $backup::params::sourceType,
  $host = $backup::params::host,
  $volume = $backup::params::volume,
  $source = $backup::params::source,
  $destination = $backup::params::destination,
  $options = $backup::params::options
) inherits backup::params {

  include 'backup'
  include 'backup::base::rdiff'

  if ($host == undef or $volume == undef or $source == undef or $destination == undef) {
    fail("Please specify all required params like host, volume, source and destination.")
  }

  case $sourceType {
    'mysql': {
      $content = template('backup/agent/rdiff/mysql')
    }
    'lvm': {
      $content = template('backup/agent/rdiff/lvm')
    }
    default: {
      fail("Unknown type ${sourceType}")
    }
  }

  file {'/root/bin/backup.sh':
    ensure => file,
    content => $content,
  }

  cron {"backup":
    command => 'bash /root/bin/backup.sh',
    user    => 'root',
    minute  => 0,
    hour    => 4,
  }
}