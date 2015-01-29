class jenkins::plugin::git_client {

  jenkins::plugin { 'git-client':
    version => '1.2.0',
  }

}
