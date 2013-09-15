define mount::entry ($source, $target, $type) {

  include 'mount::common'

  exec {"prepare ${target}":
    command => "mkdir -p ${target}; find '${target}' -type d -exec chmod -w {} \;; find '${target}' -type f -exec chmod -w {} \;;",
    unless => "mountpoint -q ${target}",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }

  mount {$target:
    ensure => present,
    fstype => $type,
    device => $source,
    require => Exec["prepare ${target}"],
    dump => '0',
    pass => '0',
    options => 'defaults',
  }

  exec {}

  cron {"mount-check ${target}":
    command => "/root/bin/mount-check.sh ${target}",
    user => 'root',
    require => File['/root/bin/mount-check.sh'],
  }
}
