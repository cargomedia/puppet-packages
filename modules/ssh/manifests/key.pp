define ssh::key ($user, $ssh_dir, $content, $type = 'ssh-rsa') {

  require 'ssh'

  exec {"${ssh_dir} for ssh::key ${name}":
    command => "mkdir -p ${ssh_dir}",
    creates => $ssh_dir,
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
  ->

  file {"${ssh_dir}/id_rsa":
    ensure => file,
    content => $content,
    group => '0',
    owner => $user,
    mode => '0600',
  }
}
