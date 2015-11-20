node default {

  exec { 'tag 2':
    command => 'touch file2 && git add -A && git commit -m "commit2" && git tag "tag2"',
    path    => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    cwd     => '/tmp/repo',
  }

}
