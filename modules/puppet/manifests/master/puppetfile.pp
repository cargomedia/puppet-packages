class puppet::master::puppetfile(
  $content,
) {

  require 'librarian_puppet'

  $update_command = "cd /etc/puppet && librarian-puppet update"

  file {'/etc/puppet/Puppetfile':
    ensure => file,
    owner => '0',
    group => '0',
    mode => '0644',
    content => $content,
  }
  ~>

  exec {$update_command:
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider => shell,
    user => 'root',
    environment => ['HOME=/root'],
    refreshonly => true,
  }

  cron {'Update puppet master Puppetfile':
    command => $update_command,
    user    => 'root',
    environment => ['PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'],
  }
}
