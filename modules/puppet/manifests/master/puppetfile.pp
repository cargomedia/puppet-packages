class puppet::master::puppetfile(
  $content,
  $hiera_data_dir  = undef,
  $puppetfile_hiera_data_dir = undef
) {

  require 'librarian_puppet'
  require 'rsync'

  if $puppetfile_hiera_data_dir != undef {
    file {$puppetfile_hiera_data_dir:
      ensure => directory,
      group => '0',
      owner => '0',
      mode => '0755',
    }

    $sync_command = "&& /usr/local/bin/sync_hiera.sh"

    file {'/usr/local/bin/sync_hiera.sh':
      ensure => file,
      content => template('puppet/sync_hiera.sh'),
      owner => '0',
      group => '0',
      mode => '0755',
      before => Exec['librarian update and rsync'],
      require => File[$hiera_data_dir, $puppetfile_hiera_data_dir],
    }
  }

  $update_command = "cd /etc/puppet && librarian-puppet update ${sync_command}"


  file {'/etc/puppet/Puppetfile':
    ensure => file,
    owner => '0',
    group => '0',
    mode => '0644',
    content => $content,
  }
  ~>

  exec {'librarian update and rsync':
    command => $update_command,
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
