define ssh::key ($host = undef, $user, $ssh_dir, $content) {

  require 'ssh'

  $keyname = $host ? {
    undef => 'id_rsa',
    default => $host,
  }

  exec {"${ssh_dir} for ${name} ${keyname}":
    command => "mkdir -p ${ssh_dir}",
    creates => $ssh_dir,
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user => $user,
  }
  ->

  file {"${ssh_dir}/${keyname}":
    ensure => file,
    content => $content,
    group => '0',
    owner => $user,
    mode => '0600',
  }

  if $host {
    exec {"mkdir ${ssh_dir}/config.d for ${host}":
      provider => shell,
      command => "mkdir -p ${ssh_dir}/config.d",
      creates => "${ssh_dir}/config.d",
      user => $user,
      require => Exec["${ssh_dir} for ${name} ${keyname}"],
    }
    ->

    file {"${ssh_dir}/config.d/${host}":
      ensure => file,
      content => template('ssh/config-host'),
      group => '0',
      owner => $user,
      mode => '0644',
    }
    ~>

    exec {"${ssh_dir}/config by ${host}":
      command => "cat ${ssh_dir}/config.d/* > ${ssh_dir}/config",
      path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
      user => $user,
      refreshonly => true,
    }
  }
}
