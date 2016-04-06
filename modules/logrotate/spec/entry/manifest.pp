node default {

  file { '/var/log/foo':
    ensure => directory,
  }

  file { '/var/log/foo/bar.log':
    ensure => file,
  }
  ->

  logrotate::entry { 'foo':
    path               => '/var/log/foo/*.log',
    rotation_frequency => 'daily',
    rotation_newfile   => 'create 0640',
    versions_to_keep   => 10,
    postrotate_script  => 'echo "*" >> /tmp/test',
    rotate_ifempty     => true,
  }
}
