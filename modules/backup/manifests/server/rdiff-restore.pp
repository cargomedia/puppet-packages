define backup::server::rdiff-restore ($host, $source, $destination, $key, $type = 'ssh-rsa') {

  ssh_authorized_key {$name:
    key => $key,
    user => 'root',
    type => $type
  }

  file {"/root/bin/restore-${source}.sh":
    ensure => file,
    content => template('backup/server/rdiff-restore'),
  }
}