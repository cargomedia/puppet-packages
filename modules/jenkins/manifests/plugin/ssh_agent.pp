class jenkins::plugin::ssh_agent {

  jenkins::plugin { 'ssh-agent':
    version => '1.10',
  }

}
