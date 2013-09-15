class mount::client {

  exec {"mkdir /root/bin":
    provider => shell,
    command => "mkdir -p /root/bin",
    creates => "/root/bin",
    user => $user,
  }
  ->

  file {'/root/bin/mount-check.sh':
    ensure => file,
    content => template('mount/mount-check.sh'),
    owner => '0',
    group => '0',
    mode => '0750',
  }
}
