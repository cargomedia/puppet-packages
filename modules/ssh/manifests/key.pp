define ssh::key (
  $user,
  $content,
  $id = $title,
  $fqdn = undef
) {

  require 'ssh'

  $ssh_dir = "~${user}/.ssh"
  $titleEscaped = shellquote($title)
  $keypath = "${ssh_dir}/id.d/${titleEscaped}"
  $contentEscaped = shellquote(chomp($content))

  exec { "${ssh_dir}/id.d for ${title}":
    command => "mkdir -p ${ssh_dir}/id.d",
    path    => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless  => "test -d ${ssh_dir}/id.d",
    user    => $user,
  }
  ->

  helper::script { $keypath:
    content => template("${module_name}/add-key.sh"),
    unless  => "test \"$(cat ${keypath})\" = ${contentEscaped}",
    user    => $user
  }
}
