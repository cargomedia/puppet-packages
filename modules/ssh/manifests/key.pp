define ssh::key ($user, $ssh_dir, $content) {

  require 'ssh'

  exec {"${ssh_dir}/id.d for ${name}":
    command => "mkdir -p ${ssh_dir}/id.d",
    creates => "${ssh_dir}/id.d",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user => $user,
  }
  ->

  file {"${ssh_dir}/id.d/${name}":
    ensure => file,
    content => $content,
    group => '0',
    owner => $user,
    mode => '0600',
  }
  ~>

  exec {"${ssh_dir}/config by ${name}":
    command => "echo -n > '${ssh_dir}/config' && find '${ssh_dir}/id.d/' -type f -not -name '*.pub' -exec echo IdentityFile {} >> '${ssh_dir}/config' \;",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user => $user,
    refreshonly => true,
  }
}
