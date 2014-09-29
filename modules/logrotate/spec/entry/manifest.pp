$logrotate_conf = '
/var/log/foo_bar.log
/var/log/foo/*.log {
  create
  rotate 7
  daily
  missingok
  delaycompress
  compress
  postrotate
    echo "*" >> /tmp/test
  endscript
}'

node default {

  file {'/var/log/foo':
    ensure => directory,
  }

  file {'/var/log/foo/bar.log':
    ensure => file,
  }
  ->

  logrotate::entry{'foo':
    content => $logrotate_conf,
  }
}
