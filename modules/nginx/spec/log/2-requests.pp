node default {

  exec { 'curl get':
    provider => shell,
    command  => '1>&2 curl --proxy "" -s http://me/bla >/dev/null',
    path     => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }

  exec { 'curl post':
    provider => shell,
    command  => '1>&2 curl --proxy ""  -X POST -H "Content-Type:application/json" -d "{\"foo\": \"bar\"}" http://me >/dev/null',
    path     => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
}
