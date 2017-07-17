class backup::agent_common {

  require 'rdiff_backup'

  file { '/usr/local/bin/backup-run.sh':
    ensure  => file,
    content => template("${module_name}/agent/rdiff/run.sh"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }

  file { '/usr/local/bin/backup-create.sh':
    ensure  => file,
    content => template("${module_name}/agent/rdiff/create.sh"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }

  file { '/usr/local/bin/backup-check.sh':
    ensure  => file,
    content => template("${module_name}/agent/rdiff/check.sh"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }

}
