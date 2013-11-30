class jenkins::plugin::ssh-agent {

  jenkins::plugin {'ssh-agent':
    version => '1.3',
  }

}
