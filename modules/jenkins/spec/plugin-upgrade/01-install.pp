node default {

  class { 'jenkins':
    hostname => 'example.com'
  }

  jenkins::plugin { 'ssh-agent':
    version => '1.3',
  }
}
