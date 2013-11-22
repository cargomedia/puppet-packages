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

  if ($host == undef or $source == undef or $destination == undef) {
    fail('Please specify all required params like host, volume, source and destination.')
  }

  case $sourceType {
    'mysql': {
      $content = template('backup/agent/rdiff/mysql')
    }
    'lvm': {
      if ($volume == undef) {
        fail('Please specify volume name for LVM agent.')
      }
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