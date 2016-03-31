$additional_config = '
  ifempty
  postrotate
    echo "*" >> /tmp/test
  endscript
'

node default {

  file { '/var/log/foo':
    ensure => directory,
  }

  file { '/var/log/foo/bar.log':
    ensure => file,
  }
  ->

  logrotate::entry{ 'foo':
    path => '/var/log/foo/*.log',
    rotation_frequency => 'daily',
    rotation_newfile => 'copytruncate',
    versions_to_keep => 10,
    additional_config => $additional_config,
  }
}
