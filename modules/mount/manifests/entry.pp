define mount::entry ($source, $target = $name, $type = 'none', $options = 'defaults') {

  include 'mount::common'

  exec {"prepare ${target}":
    command => "mkdir -p ${target}; find '${target}' -type d -exec chmod -w {} \;; find '${target}' -type f -exec chmod -w {} \;;",
    unless => "mountpoint -q ${target}",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
  ->

  mount {$target:
    ensure => present,
    fstype => $type,
    device => $source,
    require => Exec["prepare ${target}"],
    dump => '0',
    pass => '0',
    options => $options,
  }

  unless $type == 'none' {
    cron {"mount-check ${target}":
      command => "/usr/sbin/mount-check.sh ${target}",
      user => 'root',
      require => [File['/usr/sbin/mount-check.sh'], Mount[$target]]

    }

    exec {"/usr/sbin/mount-check.sh ${target}":
      command => "/usr/sbin/mount-check.sh ${target}",
      refreshonly => true,
      require => File['/usr/sbin/mount-check.sh'],
      subscribe => Mount[$target],
    }
  }
}
