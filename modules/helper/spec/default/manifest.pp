node default {

  user { 'alice':
    ensure => present,
  }

  helper::script{ 'foo':
    content => "#!/bin/sh\n echo 'hello1' >>file1\n echo 'hello2' >>/tmp/file2",
    unless  => 'test -e /tmp/hello2',
    user    => 'alice'
  }

}
