class jenkins::plugin::github_api {

  jenkins::plugin { 'github-api':
    version => '1.72.1',
  }

}
