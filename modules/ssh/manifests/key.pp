define ssh::key ($user, $content) {

  require 'ssh'

  $ssh_dir = "~${user}/.ssh"
  $nameEscaped = shellquote($name)
  $keypath = "${ssh_dir}/id.d/${nameEscaped}"
  $contentEscaped = shellquote($content)

  exec {"${ssh_dir}/id.d for ${name}":
    command => "mkdir -p ${ssh_dir}/id.d",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless => "test -d ${ssh_dir}/id.d",
    user => $user,
  }
  ->

  helper::script {$keypath:
    content => template('ssh/add-key.sh'),
    unless => "grep ^${contentEscaped}$ ${keypath}",
    user => $user
  }
}
