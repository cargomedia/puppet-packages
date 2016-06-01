define puppet::puppetfile(
  $directory = $name,
  $content,
) {

  require 'librarian_puppet'
  require 'rsync'
  require 'git'

  librarian_puppet::config { "rsync for ${directory}":
    path  => $directory,
    key   => 'rsync',
    value => true,
  }

  $update_command = "cd '${directory}' && librarian-puppet update"

  file { "${directory}/Puppetfile":
    ensure  => file,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    content => $content,
  }
  ~>

  exec { "librarian-puppet update for ${directory}":
    command     => $update_command,
    user        => 'root',
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider    => shell,
    environment => ['HOME=/root'],
    refreshonly => true,
  }

  cron { "librarian-puppet update for ${directory}":
    command     => $update_command,
    user        => 'root',
    environment => ['PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'],
  }
}
