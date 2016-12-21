node default {

  exec { 'Install packages':
    provider => shell,
    command  => 'apt-get -o Acquire::http::Proxy="http://localhost:8124/" -y install fontconfig bzip2 htop',
    path     => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }

}
