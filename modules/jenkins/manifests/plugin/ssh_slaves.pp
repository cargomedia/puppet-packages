class jenkins::plugin::ssh_slaves {

  jenkins::plugin { 'ssh-slaves':
    version => '1.10',
  }

}
